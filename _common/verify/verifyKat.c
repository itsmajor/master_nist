//
//  verifyKat.c
//
//  by Tomas Antal
//  for verifing if KAT_keygen, KAT_enc, KAT_dec has same outputs as KAT.rsp

#define  _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#define	MAX_MARKER_LEN		50
#define KAT_FILE_OPEN_ERROR -1

int		FindMarker(FILE *infile, const char *marker);
void    compareLine(FILE *file1, FILE *file2, FILE *fp_verify, char *searchString, char *kattype);

// global variable
int     countErrors = 0;


int main(int argc, char* argv[])
{
    char                fn_rsp[100], fn_rsp_keygen[100], fn_rsp_enc[100], fn_rsp_dec[100], fn_verify[100], fn_verifyresult[100];
    FILE                *fp_rsp, *fp_rsp_keygen, *fp_rsp_enc, *fp_rsp_dec, *fp_verify, *fp_verifyresult;
    unsigned char       testpath[100], pathVerify[100], pathKatBase[100], pathKatRsp[100], pathKatRspKeygen[100], pathKatRspEnc[100], pathKatRspDec[100];
    char                *searchCT, *searchPT, *verifyresultPath;
    int                 count, kattypeInt = 0;

//    printf("************* start verifyKat *************\n");
    countErrors = 0;

    // test main parameter
//    printf("argc: %d\n", argc);
//    for(int i=0; i < argc; i++) {
//        printf("argv[%d]: %s\n", i, argv[i]);
//    }
    if ( argc != 3) {
        // first param is binary name ("./verifyKat")
        // second is KATTYPE argv[1], "encrypt" or "kem"
        // third is CIPHERNAME argv[2], eg. "kyber1024"
        printf("ERROR: expect 2 param KATTYPE and CIPHERNAME\n");
        return 1;
    }

    if (strstr(argv[1], "kem")) kattypeInt = 1;
    if (strstr(argv[1], "encrypt")) kattypeInt = 2;
    if (kattypeInt == 0) {
        printf("parameter for KATTYPE expected to be 'kem' or 'encrypt'");
        return 1;
    }

    // create relative path (from _common/verify/ to testresult/ciphername/)
    verifyresultPath = "../../testresult/verifyresult.log";
    strcpy(testpath, "../../testresult/");
    strcat(testpath, argv[2]);
    strcat(testpath, "/");
//    printf("testpath is %s\n", testpath);

    // create relative common path for all KAT rsp files ("../testresult/Ding_LWQ/PQCkem")
    strcpy(pathKatBase, testpath);
    strcat(pathKatBase, "PQC");
    strcat(pathKatBase, argv[1]);

    strcpy(pathVerify, testpath);
    strcat(pathVerify, "verify.rsp");
//    printf("verify is %s\n", pathVerify);

    /* Create the VERIFYRESULT file in /testresult/ */
    sprintf(fn_verifyresult, verifyresultPath);
    if ( (fp_verifyresult = fopen(fn_verifyresult, "a")) == NULL ) {
        printf("ERROR (verifyKAT): Couldn't open '%s' for write\n", fn_verifyresult);
        return KAT_FILE_OPEN_ERROR;
    }
//    fprintf(fp_verifyresult, "%s = ", argv[2]);
//    fflush(fp_verifyresult);
    /* Create the VERIFY file */
    sprintf(fn_verify, pathVerify);
    if ( (fp_verify = fopen(fn_verify, "w")) == NULL ) {
        printf("ERROR (verifyKAT): Couldn't open '%s' for write\n", fn_verify);
        return KAT_FILE_OPEN_ERROR;
    }

    // read PQC*KAT.rsp (* kem or encrypt)
    strcpy(pathKatRsp, pathKatBase);
    strcat(pathKatRsp, "KAT.rsp");
//    printf("path of KAT.rsp is %s\n", pathKatRsp);
    sprintf(fn_rsp, pathKatRsp);
    if ( (fp_rsp = fopen(fn_rsp, "r")) == NULL ) {
        printf("ERROR (verifyKAT): Couldn't open '%s' for read\n", fn_rsp);
        return KAT_FILE_OPEN_ERROR;
    }

    // read PQC*KAT_keygen.rsp (* kem or encrypt)
    strcpy(pathKatRspKeygen, pathKatBase);
    strcat(pathKatRspKeygen, "KAT_keygen.rsp");
//    printf("path of KAT_keygen.rsp is %s\n", pathKatRspKeygen);
    sprintf(fn_rsp_keygen, pathKatRspKeygen);
    if ( (fp_rsp_keygen = fopen(fn_rsp_keygen, "r")) == NULL ) {
        printf("WARN (verifyKAT): Couldn't open '%s' for read. (verification will be skipped)\n", fn_rsp_keygen);
    }

    // read PQC*KAT_enc.rsp (* kem or encrypt)
    strcpy(pathKatRspEnc, pathKatBase);
    strcat(pathKatRspEnc, "KAT_enc.rsp");
//    printf("path of KAT_enc.rsp is %s\n", pathKatRspEnc);
    sprintf(fn_rsp_enc, pathKatRspEnc);
    if ( (fp_rsp_enc = fopen(fn_rsp_enc, "r")) == NULL ) {
        printf("WARN (verifyKAT): Couldn't open '%s' for read. (verification will be skipped)\n", fn_rsp_enc);
    }

    // read PQC*KAT_dec.rsp (* kem or encrypt)
    strcpy(pathKatRspDec, pathKatBase);
    strcat(pathKatRspDec, "KAT_dec.rsp");
//    printf("path of KAT_dec.rsp is %s\n", pathKatRspDec);
    sprintf(fn_rsp_dec, pathKatRspDec);
    if ( (fp_rsp_dec = fopen(fn_rsp_dec, "r")) == NULL ) {
        printf("WARN (verifyKAT): Couldn't open '%s' for read. (verification will be skipped)\n", fn_rsp_dec);
    }


    fprintf(fp_verify, "Errors = ?              \n\n");
    while (1) {
        if ( FindMarker(fp_rsp, "count = ") )
            fscanf(fp_rsp, "%d", &count);
        else {
            break;
        }
        fprintf(fp_verify, "\ncount = %d\n", count);

        // order for line reading important
        // 1/kem: seed, pk, sk, ct, ss
        // 2/encrypt: seed, msg, pk, sk, c
        if (kattypeInt == 1) {
            searchCT = "ct = ";
            searchPT = "ss = ";

            if (fp_rsp_keygen != NULL) {
                compareLine(fp_rsp, fp_rsp_keygen, fp_verify, "seed = ", "key");
                compareLine(fp_rsp, fp_rsp_keygen, fp_verify, "pk = ", "key");
                compareLine(fp_rsp, fp_rsp_keygen, fp_verify, "sk = ", "key");
            }
            if (fp_rsp_enc != NULL) {
                compareLine(fp_rsp, fp_rsp_enc, fp_verify, searchCT, "enc");
            }
            if (fp_rsp_dec != NULL) {
                compareLine(fp_rsp, fp_rsp_dec, fp_verify, searchPT, "dec");
            }
        } else if (kattypeInt == 2) {
            searchCT = "c = ";
            searchPT = "msg = ";

            if (fp_rsp_keygen != NULL) {
                compareLine(fp_rsp, fp_rsp_keygen, fp_verify, "seed = ", "key");
            }
            if (fp_rsp_dec != NULL) {
                compareLine(fp_rsp, fp_rsp_dec, fp_verify, searchPT, "dec");
            }
            if (fp_rsp_keygen != NULL) {
                compareLine(fp_rsp, fp_rsp_keygen, fp_verify, "pk = ", "key");
                compareLine(fp_rsp, fp_rsp_keygen, fp_verify, "sk = ", "key");
            }
            if (fp_rsp_enc != NULL) {
                compareLine(fp_rsp, fp_rsp_enc, fp_verify, searchCT, "enc");
            }
        }


    }

    fseek(fp_verify, 0, SEEK_SET);
    fprintf(fp_verify, "Errors = %i   ", countErrors);


    // write result to verifyresult.log (to end of file, keep previous content)
    fprintf(fp_verifyresult, "%s = ", argv[2]);
    if (countErrors > 0) {
        printf("verifyKAT %s - ERRORS found: %i (%s)\n", argv[2], countErrors, pathVerify);
        fprintf(fp_verifyresult, "ERROR (count = %d)\n", countErrors);
    } else {
        printf("verifyKAT %s - OK\n", argv[2]);
        fprintf(fp_verifyresult, "OK\n");
    }


//    printf("*********** end of verifyKat - closing files ****************\n");
    fclose(fp_verify);
    fclose(fp_verifyresult);
    fclose(fp_rsp);
    if (fp_rsp_keygen != NULL) fclose(fp_rsp_keygen);
    if (fp_rsp_enc != NULL) fclose(fp_rsp_enc);
    if (fp_rsp_dec != NULL) fclose(fp_rsp_dec);

}

void compareLine(FILE *file1, FILE *file2, FILE *fp_verify, char *searchString, char *kattype) {
    char *line1 = NULL;
    char *line2 = NULL;
    size_t size1 = 0;
    size_t size2 = 0;

    while (1) {
        getline(&line1, &size1, file1);
        if (strstr(line1, searchString)) break;
    }
//    printf("read line pk: %s\n", pk);
    while (1) {
        getline(&line2, &size2, file2);
        if (strstr(line2, searchString)) break;
    }
//    printf("read line pk_keygen: %s\n", pk);

    if (strcmp(line1, line2) == 0) {
        if (strcmp(searchString, "msg = ") == 0) {
            fprintf(fp_verify, "%s %sOK \t\t '%.*s...'\n", kattype, searchString, 32, line1);
        } else {
            fprintf(fp_verify, "%s %sOK \t\t '%.*s...'\n", kattype, searchString, 40, line1);
        }
    } else {
        fprintf(fp_verify, "%s %sERROR \t\t not equal: '%.*s...' vs '%.*s...'\n", kattype, searchString, 20, line1, 20, line2);
        fprintf(fp_verify, "line1: %s\n", line1);
        fprintf(fp_verify, "line2: %s\n", line2);
        printf("%s %sERROR - not equal - '%.*s...' vs '%.*s...'\n", kattype, searchString, 20, line1, 20, line2);
        countErrors += 1;
    }
}

// (from NIST PQCkemKAT.c)
// ALLOW TO READ HEXADECIMAL ENTRY (KEYS, DATA, TEXT, etc.)
//
int
FindMarker(FILE *infile, const char *marker)
{
	char	line[MAX_MARKER_LEN];
	int		i, len;
	int curr_line;

	len = (int)strlen(marker);
	if ( len > MAX_MARKER_LEN-1 )
		len = MAX_MARKER_LEN-1;

	for ( i=0; i<len; i++ )
	  {
	    curr_line = fgetc(infile);
	    line[i] = curr_line;
	    if (curr_line == EOF )
	      return 0;
	  }
	line[len] = '\0';

	while ( 1 ) {
		if ( !strncmp(line, marker, len) )
			return 1;

		for ( i=0; i<len-1; i++ )
			line[i] = line[i+1];
		curr_line = fgetc(infile);
		line[len-1] = curr_line;
		if (curr_line == EOF )
		    return 0;
		line[len] = '\0';
	}

	// shouldn't get here
	return 0;
}


#pragma clang diagnostic pop