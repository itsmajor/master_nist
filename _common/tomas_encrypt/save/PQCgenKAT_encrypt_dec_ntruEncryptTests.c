//
//  PQCgenKAT_encrypt.c
//
//  Created by Bassham, Lawrence E (Fed) on 8/29/17.
//  Copyright © 2017 Bassham, Lawrence E (Fed). All rights reserved.
//
// changed by Tomas Antal for time measurement
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include "../NIST/rng.h"
#include "api.h"
#include <time.h>
#include <stdlib.h>
#include <stdbool.h>

#define	MAX_MARKER_LEN		50
#define KAT_SUCCESS          0
#define KAT_FILE_OPEN_ERROR -1
#define KAT_DATA_ERROR      -3
#define KAT_CRYPTO_FAILURE  -4

#ifndef CRYPTO_ALGNAME
#define CRYPTO_ALGNAME = "unset"
#endif

int		FindMarker(FILE *infile, const char *marker);
int		ReadHex(FILE *infile, unsigned char *A, int Length, char *str);
void	fprintBstr(FILE *fp, char *S, unsigned char *A, unsigned long long L);
void hex_to_bin(size_t size, unsigned char *dest, const char *input);

// global variable
bool    debug = true;

int
main(int argc, char* argv[])
{
    char                fn_req[32], fn_rsp[32];
    FILE                *fp_req, *fp_rsp;
    unsigned char       seed[48];
    unsigned char       msg[3300];
    unsigned char       entropy_input[48];
    unsigned char       *m, *c, *m1;
    unsigned long long  mlen, clen, mlen1;
    int                 count;
    unsigned char       pk[CRYPTO_PUBLICKEYBYTES], sk[CRYPTO_SECRETKEYBYTES];
    int                 ret_val, repeats = 10;


    if ( argc > 1) { //argv[0] is this binary name
        char *output;
        // amount of repeats for req file
        repeats = atoi( argv[1] );
        if ( argc > 2 && strcmp(argv[2], "1") == 0) {
            debug = true;
            printf("start main PQCgenKAT_encrypt (argc: %i)\n", argc);
            for (int i = 0; i < argc; i++) {
                printf("argv[%d]: %s\n", i, argv[i]);
            }
            printf("repeats: %i\n", repeats);
        }
    }

    // Create the REQUEST file
//    sprintf(fn_req, "PQCencryptKAT.req");
//    if ( (fp_req = fopen(fn_req, "w")) == NULL ) {
//        printf("PQCgenKAT ERROR: Couldn't open <%s> for write\n", fn_req);
//        return KAT_FILE_OPEN_ERROR;
//    }
    sprintf(fn_rsp, "PQCencryptKAT_dec.rsp");
    if ( (fp_rsp = fopen(fn_rsp, "w")) == NULL ) {
        printf("PQCgenKAT ERROR: Couldn't open <%s> for write\n", fn_rsp);
        return KAT_FILE_OPEN_ERROR;
    }
    fprintf(fp_rsp, "# %s\n\n", CRYPTO_ALGNAME);

//    for (int i=0; i<48; i++)
//        entropy_input[i] = i;

//    randombytes_init(entropy_input, NULL, 256);
//    // only in NTRUEncrypt is this used (i<3), simplified here
////    for (int i=0; i<1; i++) {
//        for (int j=0; j<repeats; j++) {
////            fprintf(fp_req, "count = %d\n", i*25+j);
//            fprintf(fp_req, "count = %d\n", j);
//            randombytes(seed, 48);
//            fprintBstr(fp_req, "seed = ", seed, 48);
////            mlen = 16+i*8;
//            mlen = 16;
//            fprintf(fp_req, "mlen = %lld\n", mlen);
//            randombytes(msg, mlen);
//            fprintBstr(fp_req, "msg = ", msg, mlen);
//            fprintf(fp_req, "pk =\n");
//            fprintf(fp_req, "sk =\n");
//            fprintf(fp_req, "clen =\n");
//            fprintf(fp_req, "c =\n\n");
//        }
////    }
//    fclose(fp_req);

    //Create the RESPONSE file based on what's in the REQUEST file
    sprintf(fn_req, "PQCencryptKAT.rsp");
    if ( (fp_req = fopen(fn_req, "r")) == NULL ) {
        printf("PQCgenKAT ERROR: Couldn't open <%s> for read\n", fn_req);
        return KAT_FILE_OPEN_ERROR;
    }

    //Create the RESPONSE file based on what's in the REQUEST file
//    if ( (fp_req = fopen(fn_req, "r")) == NULL ) {
//        printf("PQCgenKAT ERROR: Couldn't open <%s> for read\n", fn_req);
//        return KAT_FILE_OPEN_ERROR;
//    }

    if (debug) printf("start looping\n");
    while (1) {
        if ( FindMarker(fp_req, "count = ") )
            fscanf(fp_req, "%d", &count);
        else {
            break;
        }
        fprintf(fp_rsp, "count = %d\n", count);
        if (debug) printf("loop count: %d\n", count);

        if ( !ReadHex(fp_req, seed, 48, "seed = ") ) {
            printf("PQCgenKAT ERROR: unable to read 'seed' from <%s>\n", fn_req);
            return KAT_DATA_ERROR;
        }
        fprintBstr(fp_rsp, "seed = ", seed, 48);
        randombytes_init(seed, NULL, 256);
        if (debug) printHex("randombytes_init seed: ", seed, 48, false);

        if ( FindMarker(fp_req, "mlen = ") )
            fscanf(fp_req, "%llu", &mlen);
        else {
            printf("ERROR: unable to read 'mlen' from <%s>\n", fn_req);
            return KAT_DATA_ERROR;
        }
        fprintf(fp_rsp, "mlen = %llu\n", mlen);
        if (debug) printf("mlen: %llu\n", mlen);

        if (strcmp(CRYPTO_ALGNAME, "NTRU_PKE_443") == 0 || strcmp(CRYPTO_ALGNAME, "NTRU_PKE_443") == 0) {
            //NTRUEncrypt use modified kat.c -> 'c = (unsigned char *)calloc(mlen+CRYPTO_CIPHERTEXTBYTES, ...'
            clen = CRYPTO_PUBLICKEYBYTES;
        } else {
            //doesn't make sense - but works everywhere else
            clen = mlen + CRYPTO_BYTES;
        }

        m = (unsigned char *)calloc(mlen+1, sizeof(unsigned char));
        m1 = (unsigned char *)calloc(mlen+CRYPTO_BYTES, sizeof(unsigned char));
        c = (unsigned char *)calloc(clen+1, sizeof(unsigned char));
        // NTRUEncrypt use here:  c = (unsigned char *)calloc(mlen+CRYPTO_CIPHERTEXTBYTES, sizeof(unsigned char));
        if (debug) printf("calloc (m, m1, c) done\n");

        if ( !ReadHex(fp_req, m, (int)mlen, "msg = ") ) {
            printf("ERROR: unable to read 'msg' from <%s>\n", fn_req);
            return KAT_DATA_ERROR;
        }
        fprintBstr(fp_rsp, "msg = ", m, mlen);
        if (debug) printHex("msg", msg, mlen, false);

        ReadHex(fp_req, pk, CRYPTO_PUBLICKEYBYTES, "pk = ");
        if (debug) printHex("pk", pk, CRYPTO_PUBLICKEYBYTES, false);

        ReadHex(fp_req, sk, CRYPTO_SECRETKEYBYTES, "sk = ");
        if (debug) printHex("sk", sk, CRYPTO_SECRETKEYBYTES, false);

        // Generate the public/private keypair
//        if (debug) printf("do crypto_encrypt_keypair()\n");
//        if ( (ret_val = crypto_encrypt_keypair(pk, sk)) != 0) {
//            printf("PQCgenKAT ERROR: crypto_encrypt_keypair returned <%d>\n", ret_val);
//            return KAT_CRYPTO_FAILURE;
//        }
//        fprintBstr(fp_rsp, "pk = ", pk, CRYPTO_PUBLICKEYBYTES);
//        fprintBstr(fp_rsp, "sk = ", sk, CRYPTO_SECRETKEYBYTES);
//        if (debug) { printHex("pk", pk, CRYPTO_PUBLICKEYBYTES, false); printHex("sk", sk, CRYPTO_SECRETKEYBYTES, false); }

        // encoding
        // if encrypt use randombytes then we need to reinit for same results as _enc run
        randombytes_init(seed, NULL, 256);
        if (debug) printf("do crypto_encrypt()\n");
        if ( (ret_val = crypto_encrypt(c, &clen, m, mlen, pk)) != 0) {
            printf("PQCgenKAT ERROR: crypto_encrypt returned <%d>\n", ret_val);
            return KAT_CRYPTO_FAILURE;
        }
        if (debug) printHex("c", c, clen, false);

//        ReadHex(fp_req, sk, CRYPTO_SECRETKEYBYTES, "sk = ");
//        if (debug) printHex("sk2", sk, CRYPTO_SECRETKEYBYTES, false);

//        free(c);
//        c = (unsigned char *)calloc(clen+1, sizeof(unsigned char));
        /*unsigned char       *x;
        x = (unsigned char *)calloc(clen+1, sizeof(unsigned char));
        ReadHex(fp_req, x, clen+1, "c = ");
        if (debug) printHex("x", x, clen, false);*/

        unsigned char       ct[CRYPTO_PUBLICKEYBYTES*2];
        ReadHex(fp_req, ct, clen, "c = ");
//        ct[clen] = '\0';
        if (debug) printHex("ct", ct, clen, false);
        c = ct;


        fprintf(fp_rsp, "clen = %llu\n", clen);
        fprintBstr(fp_rsp, "c = ", c, clen);
        fprintf(fp_rsp, "\n");
        if (debug) {
            printf("clen: %llu\n", clen);
            printHex("c", c, (clen > 30 ? 30 : clen), true);
        }
        if (debug) printf("do crypto_encrypt_open()\n");
        if ( (ret_val = crypto_encrypt_open(m1, &mlen1, c, clen, sk)) != 0) {
            printf("crypto_encrypt_open returned <%d>\n", ret_val);
            return KAT_CRYPTO_FAILURE;
        }
        if (debug) printHex("m1", m1, mlen1, false);

        if ( mlen != mlen1 ) {
            printf("PQCgenKAT ERROR: crypto_encrypt_open returned bad 'mlen': Got <%llu>, expected <%llu>\n", mlen1, mlen);
//            return KAT_CRYPTO_FAILURE;
        }
        
        if ( memcmp(m, m1, mlen) ) {
            printf("PQCgenKAT ERROR: crypto_encrypt_open returned bad 'm' value\n");
            return KAT_CRYPTO_FAILURE;
        }

        if (debug) printf("release pointer\n");
        free(m);
        free(m1);
        free(c);

    }
    if (debug) printf("finish looping\n");


    fclose(fp_req);
    fclose(fp_rsp);

    return KAT_SUCCESS;
}

void printHex(char *fieldname, char *hexstring, int printamount, bool printDots) {
    printf("%s: ", fieldname);
    char *cp = hexstring;
    for (int i = 0; i < printamount /*&& *cp != '\0'*/; i++) printf("%02X", *cp++);
    if (printDots) printf("...");
    printf("\n");
}

//
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

//
// ALLOW TO READ HEXADECIMAL ENTRY (KEYS, DATA, TEXT, etc.)
//
int
ReadHex(FILE *infile, unsigned char *A, int Length, char *str) {
    clock_t start;
    if (debug) {
        start = clock();
        printf("in ReadHex (Length: %i, search: '%s')", Length, str);
    }

    if (Length == 0) {
        A[0] = 0x00;
        return 1;
    }
    memset(A, 0x00, Length);

    char *line = NULL;
    size_t size1 = 0;
    FindMarker(infile, str);
    getline(&line, &size1, infile);
    hex_to_bin(Length, A, line);
    if (debug) printf(" (took: %.0f μs)\n", ((double) (clock() - start)));
    return 1;
}

void hex_to_bin(size_t size, unsigned char *dest, const char *input) {
    unsigned char *s = dest, digit1, digit2;
    unsigned int ich1, ich2;
    for (size_t i = 0; i < size; i++) {
        digit1 = input[i*2];
        digit2 = input[i*2 + 1];

        // A = 65
        // 0 = 48
        if (digit1 >= 65)
            ich1 = digit1 - 55;
        else
            ich1 = digit1 - 48;

        if (digit2 >= 65)
            ich2 = digit2 - 55;
        else
            ich2 = digit2 - 48;

        *s++ = (unsigned char) ((ich1<<4) + ich2);
    }
//    *s = '\0';
}

void
fprintBstr(FILE *fp, char *S, unsigned char *A, unsigned long long L)
{
	unsigned long long  i;

	fprintf(fp, "%s", S);

	for ( i=0; i<L; i++ )
		fprintf(fp, "%02X", A[i]);

	if ( L == 0 )
		fprintf(fp, "00");

	fprintf(fp, "\n");
}

