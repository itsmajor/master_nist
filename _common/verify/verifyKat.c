//
//  verifyKat.c
//
//  by Tomas Antal
//  for verifing if KAT_keygen, KAT_enc, KAT_dec has same outputs as KAT.rsp

#define  _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdbool.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#define	MAX_MARKER_LEN		50
#define KAT_FILE_OPEN_ERROR -1

int		FindMarker(FILE *infile, const char *marker);
void    compareLine(FILE *file1, FILE *file2, FILE *fp_verify, char *searchString, char *kattype, int count);

// global variable
int     countErrors = 0, comparedLines = 0;
bool    debug = false;


int main(int argc, char* argv[])
{
    char        fn_rsp[100], fn_rsp_keygen[100], fn_rsp_enc[100], fn_rsp_dec[100], fn_verify[100], fn_verifyresult[100];
    FILE        *fp_rsp, *fp_rsp_keygen, *fp_rsp_enc, *fp_rsp_dec, *fp_verify, *fp_verifyresult;
    char        testpath[100], pathVerify[100], pathKatBase[100], pathKatRsp[100], pathKatRspKeygen[100],
                pathKatRspEnc[100], pathKatRspDec[100], verified[100], knownError[100];
    char        *verifyresultPath;
    int         count = 0, kattypeInt = 0;

    printf("verifyKat: start\n");
    countErrors = 0;

    if (argc < 3) {
        printf("ERROR (verifyKAT): expect 2 param KATTYPE and CIPHERNAME \n(3rd param =1 will enable debug)\n");
        return 1;
    }
    if (argc == 4) {
        if (strcmp(argv[3], "1") == 0) {
            debug = true;
            printf("start main verifyKat (argc: %i)\n", argc);
            for (int i = 0; i < argc; i++) {
                printf("argv[%d]: %s\n", i, argv[i]);
            }
        }
    }


    if (strstr(argv[1], "kem")) kattypeInt = 1;
    if (strstr(argv[1], "encrypt")) kattypeInt = 2;
    if (strstr(argv[1], "sign")) kattypeInt = 3;
    if (kattypeInt == 0) {
        printf("parameter for KATTYPE expected to be 'kem', 'encrypt' or 'sign'");
        return 1;
    }

    // create relative path (from _common/verify/ to testresult/ciphername/)
    verifyresultPath = "../../testresult/verifyresult.log";
    strcpy(testpath, "../../testresult/");
    strcat(testpath, argv[2]);
    strcat(testpath, "/");

    // create relative common path for all KAT rsp files ("../testresult/Ding_LWQ/PQCkem")
    strcpy(pathKatBase, testpath);
    strcat(pathKatBase, "PQC");
    strcat(pathKatBase, argv[1]);

    strcpy(pathVerify, testpath);
    strcat(pathVerify, "verify.rsp");
    if (debug) {
        printf("testpath is %s\n", testpath);
        printf("verify is %s\n", pathVerify);
    }

    /* Create the VERIFYRESULT file in /testresult/ */
    sprintf(fn_verifyresult, "%s", verifyresultPath);
    if ( (fp_verifyresult = fopen(fn_verifyresult, "a")) == NULL ) {
        printf("ERROR (verifyKAT): Couldn't open '%s' for write\n", fn_verifyresult);
        return KAT_FILE_OPEN_ERROR;
    }

    /* Create the VERIFY file */
    sprintf(fn_verify, "%s", pathVerify);
    if ( (fp_verify = fopen(fn_verify, "w")) == NULL ) {
        printf("ERROR (verifyKAT): Couldn't open '%s' for write\n", fn_verify);
        return KAT_FILE_OPEN_ERROR;
    }

    // read PQC*KAT.rsp (* kem or encrypt)
    strcpy(pathKatRsp, pathKatBase);
    strcat(pathKatRsp, "KAT.rsp");
    sprintf(fn_rsp, "%s", pathKatRsp);
    if ( (fp_rsp = fopen(fn_rsp, "r")) == NULL ) {
        printf("ERROR (verifyKAT): Couldn't open '%s' for read\n", fn_rsp);
        return KAT_FILE_OPEN_ERROR;
    }

    // read PQC*KAT_keygen.rsp (* kem or encrypt)
    strcpy(pathKatRspKeygen, pathKatBase);
    strcat(pathKatRspKeygen, "KAT_keygen.rsp");
    sprintf(fn_rsp_keygen, "%s", pathKatRspKeygen);
    if ( (fp_rsp_keygen = fopen(fn_rsp_keygen, "r")) == NULL ) {
        printf("WARN (verifyKAT): Couldn't open '%s' for read. (verification will be skipped)\n", fn_rsp_keygen);
    }

    // read PQC*KAT_enc.rsp (* kem or encrypt)
    strcpy(pathKatRspEnc, pathKatBase);
    strcat(pathKatRspEnc, "KAT_enc.rsp");
    sprintf(fn_rsp_enc, "%s", pathKatRspEnc);
    if ( (fp_rsp_enc = fopen(fn_rsp_enc, "r")) == NULL ) {
        printf("WARN (verifyKAT): Couldn't open '%s' for read. (verification will be skipped)\n", fn_rsp_enc);
    }

    // read PQC*KAT_dec.rsp (* kem or encrypt)
    strcpy(pathKatRspDec, pathKatBase);
    strcat(pathKatRspDec, "KAT_dec.rsp");
    sprintf(fn_rsp_dec, "%s", pathKatRspDec);
    if ( (fp_rsp_dec = fopen(fn_rsp_dec, "r")) == NULL ) {
        printf("WARN (verifyKAT): Couldn't open '%s' for read. (verification will be skipped)\n", fn_rsp_dec);
    }

    if (debug) printf("start looping\n");
    fprintf(fp_verify, "Errors = ?       \n                                                  \n");
    while (1) {
        if ( FindMarker(fp_rsp, "count = ") )
            fscanf(fp_rsp, "%d", &count);
        else {
            break;
        }
        fprintf(fp_verify, "\ncount = %d\n", count);
        if (debug) printf("loop count: %d\n", count);

        // order for line reading important
        // 1/kem: seed, pk, sk, ct, ss
        // 2/encrypt: seed, msg, pk, sk, c
        if (kattypeInt == 1) {
            if (fp_rsp_keygen != NULL) {
                compareLine(fp_rsp, fp_rsp_keygen, fp_verify, "seed = ", "key", count);
                compareLine(fp_rsp, fp_rsp_keygen, fp_verify, "pk = ", "key", count);
                compareLine(fp_rsp, fp_rsp_keygen, fp_verify, "sk = ", "key", count);
            }
            if (fp_rsp_enc != NULL) {
                compareLine(fp_rsp, fp_rsp_enc, fp_verify, "ct = ", "enc", count);
            }
            if (fp_rsp_dec != NULL) {
                compareLine(fp_rsp, fp_rsp_dec, fp_verify, "ss = ", "dec", count);
            }
        } else if (kattypeInt == 2) {
            if (fp_rsp_keygen != NULL) {
                compareLine(fp_rsp, fp_rsp_keygen, fp_verify, "seed = ", "key", count);
            }
            if (fp_rsp_dec != NULL) {
                compareLine(fp_rsp, fp_rsp_dec, fp_verify, "msg = ", "dec", count);
            }
            if (fp_rsp_keygen != NULL) {
                compareLine(fp_rsp, fp_rsp_keygen, fp_verify, "pk = ", "key", count);
                compareLine(fp_rsp, fp_rsp_keygen, fp_verify, "sk = ", "key", count);
            }
            if (fp_rsp_enc != NULL) {
                compareLine(fp_rsp, fp_rsp_enc, fp_verify, "c = ", "enc", count);
            }
        } else if (kattypeInt == 3) {
            if (fp_rsp_keygen != NULL) {
                compareLine(fp_rsp, fp_rsp_keygen, fp_verify, "seed = ", "key", count);
            }
            if (fp_rsp_dec != NULL) {
                compareLine(fp_rsp, fp_rsp_dec, fp_verify, "msg = ", "dec", count);
            }
            if (fp_rsp_keygen != NULL) {
                compareLine(fp_rsp, fp_rsp_keygen, fp_verify, "pk = ", "key", count);
                compareLine(fp_rsp, fp_rsp_keygen, fp_verify, "sk = ", "key", count);
            }
            if (fp_rsp_enc != NULL) {
                compareLine(fp_rsp, fp_rsp_enc, fp_verify, "sm = ", "enc", count);
            }
        }
    }
    if (debug) printf("finish looping (repeats: %i)\n", count);

    if (fp_rsp_keygen != NULL) {
        strcat(verified, "keygen ");
    }
    if (fp_rsp_enc != NULL) {
        strcat(verified, "enc ");
    }
    if (fp_rsp_dec != NULL) {
        strcat(verified, "dec");
    }

    strcpy(knownError, "");
    // known errors - mark with 'KNOWN'
    if (strstr(argv[2], "pqNTRUSign-")
        || strstr(argv[2], "Picnic_")
        || strstr(argv[2], "sphincs-sha256-")
            ) {
        printf("this is a known error cancidate!\n");
        strcpy(knownError, "(KNOWN ERROR) ");

//        fprintf(fp_verifyresult, "%s = SKIP (own RNG / creates new results)\n", argv[2]);
//        fclose(fp_verifyresult);
//        return 0;
    }

    // replace first 2 lines (written before loop)
    fseek(fp_verify, 0, SEEK_SET);
    fprintf(fp_verify, "Errors = %i   \nverified: %s", countErrors, verified);


    // write result to verifyresult.log (to end of file, keep previous content)
    fprintf(fp_verifyresult, "%s = ", argv[2]);
    if (countErrors > 0) {
        printf("verifyKAT: %s - ERRORS %sfound: %i (%s)", argv[2], knownError, countErrors, pathVerify);
        fprintf(fp_verifyresult, "ERROR %s(count = %d) (%s)", knownError, countErrors, verified);
    } else if (comparedLines > 0) {
        printf("verifyKAT: %s - OK %s(%s)", argv[2], knownError, verified);
        fprintf(fp_verifyresult, "OK %s(%s)", knownError, verified);
    } else {
        printf("verifyKAT: %s - nothing compared", argv[2]);
        fprintf(fp_verifyresult, "nothing compared");
    }
    time_t timer = time(NULL);
    char printtime[20];
    strftime(printtime, 20, "%d.%m.%Y %H:%M:%S", localtime(&timer));
    if (comparedLines > 0) {
        printf(" (%s) (repeats: %i, comparedLines: %i)\n", printtime, count + 1, comparedLines);
        fprintf(fp_verifyresult, " (%s) (repeats: %i, comparedLines: %i)\n", printtime, count + 1, comparedLines);
    } else {
        printf(" (%s) (count at %i)\n", printtime, count);
        fprintf(fp_verifyresult, " (%s) (count at %i)\n", printtime, count);
    }

//    printf("*********** end of verifyKat - closing files ****************\n");
    fclose(fp_verify);
    fclose(fp_verifyresult);
    fclose(fp_rsp);
    if (fp_rsp_keygen != NULL) fclose(fp_rsp_keygen);
    if (fp_rsp_enc != NULL) fclose(fp_rsp_enc);
    if (fp_rsp_dec != NULL) fclose(fp_rsp_dec);
}


void compareLine(FILE *file1, FILE *file2, FILE *fp_verify, char *searchString, char *kattype, int count) {
    char *line1 = NULL;
    char *line2 = NULL;
    size_t size1 = 0;
    size_t size2 = 0;

    if (debug) printf("in compareLine (%s) search for '%s'\n", kattype, searchString);

    if (FindMarker(file1, searchString)) {
        getline(&line1, &size1, file1); //size is alloc, not real length
        size1 = strlen(line1)-1; //do not count '\0'
    } else {
        printf("%s (%i) %sERROR - line1 not found\n", kattype, count, searchString);
        countErrors++;
        return;
    }
    if (debug) printf("line1 (size: %zu): %.*s\n", size1, (int)(size1 < 100 ? size1 : 100), line1);

    if (FindMarker(file2, searchString)) {
        getline(&line2, &size2, file2);
        size2 = strlen(line2)-1;
    } else {
        printf("%s (%i) %sERROR - line1 not found\n", kattype, count, searchString);
        countErrors++;
        return;
    }
    if (debug) printf("line2 (size: %zu): %.*s\n", size2, (int)(size2 < 100 ? size2 : 100), line2);


    if (strcmp(line1, line2) == 0) {
        if (strcmp(searchString, "msg = ") == 0) {
            fprintf(fp_verify, "%s %sOK \t\t '%.*s...'\n", kattype, searchString, 32, line1);
        } else {
            fprintf(fp_verify, "%s %sOK \t\t '%.*s...'\n", kattype, searchString, 40, line1);
        }
        if (debug) printf("lines are equal\n");
    } else {
        fprintf(fp_verify, "%s %sERROR \t\t not equal: '%.*s...' vs '%.*s...'\n", kattype, searchString, 20, line1, 20, line2);
        fprintf(fp_verify, "line1: %s", line1);
        fprintf(fp_verify, "line2: %s", line2);
        printf("%s (%i) %sERROR - not equal - '%.*s...' vs '%.*s...'\n", kattype, count, searchString, 20, line1, 20, line2);
        countErrors++;
    }
    comparedLines++;
    free(line1);
    free(line2);
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