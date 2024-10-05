
//
//  PQCgenKAT_sign.c
//
//  Created by Bassham, Lawrence E (Fed) on 8/29/17.
//  Copyright © 2017 Bassham, Lawrence E (Fed). All rights reserved.
//
// changed by Tomas Antal for time measurement
#include <stdio.h>
#include <string.h>
//#include <ctype.h>
#include "rng.h"
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
void    hex_to_bin(size_t size, unsigned char *dest, const char *input);
void    printHex(char *fieldname, char *hexstring, int printamount, bool printDots);

// global variable
bool    debug = false;

int
main(int argc, char* argv[])
{
    char                fn_req[32], fn_rsp[32], fn_time[32];
    FILE                *fp_req, *fp_rsp, *fp_time;
    unsigned char       seed[48];
    unsigned char       msg[3300];
    unsigned char       entropy_input[48];
    unsigned char       *m, *sm, *m1;
    unsigned long long  mlen, smlen, mlen1;
    int                 count;
    unsigned char       pk[CRYPTO_PUBLICKEYBYTES], sk[CRYPTO_SECRETKEYBYTES];
    int                 ret_val, repeats = 10;
    clock_t             start, progStart;
    double              time_keypair, time_sign, time_verify, time_prepare;
//    unsigned char       *pk, *sk;

    progStart = clock();

    if ( argc > 1) { //argv[0] is this binary name
        char *output;
        // amount of repeats for req file
        repeats = atoi( argv[1] );
        if ( argc > 2 && strcmp(argv[2], "1") == 0) {
            debug = true;
            printf("start main PQCgenKAT_sign (argc: %i)\n", argc);
            for (int i = 0; i < argc; i++) {
                printf("argv[%d]: %s\n", i, argv[i]);
            }
            printf("repeats: %i\n", repeats);
        }
    }

    // from GUI original genKAT
//    pk = (unsigned char *) calloc(CRYPTO_PUBLICKEYBYTES, sizeof(unsigned char));
//    sk = (unsigned char *) calloc(CRYPTO_SECRETKEYBYTES, sizeof(unsigned char));
//    if ((pk == NULL) || (sk == NULL)) {
//        printf("alloc memory for pk/sk fail.\n");
//        return -1;
//    }

    // Create the REQUEST file
    sprintf(fn_req, "PQCsignKAT.req");
    if ( (fp_req = fopen(fn_req, "w")) == NULL ) {
        printf("PQCgenKAT ERROR: Couldn't open <%s> for write\n", fn_req);
        return KAT_FILE_OPEN_ERROR;
    }
    sprintf(fn_rsp, "PQCsignKAT.rsp");
    if ( (fp_rsp = fopen(fn_rsp, "w")) == NULL ) {
        printf("PQCgenKAT ERROR: Couldn't open <%s> for write\n", fn_rsp);
        return KAT_FILE_OPEN_ERROR;
    }
    sprintf(fn_time, "PQCsignKAT.time");
    if ( (fp_time = fopen(fn_time, "w")) == NULL ) {
        printf("PQCgenKAT ERROR: Couldn't open <%s> for write\n", fn_time);
        return KAT_FILE_OPEN_ERROR;
    }
    fprintf(fp_rsp, "# %s\n\n", CRYPTO_ALGNAME);
    fprintf(fp_time, "# %s\n\n", CRYPTO_ALGNAME);
    fprintf(fp_time, "reserved for full time output                                                  \n");
    fprintf(fp_time, "time since start to open rsp file (μs) = %.0f\n", ((double) (clock() - progStart)));

    for (int i = 0; i < 48; i++)
        entropy_input[i] = i;

    randombytes_init(entropy_input, NULL, 256);
    fprintf(fp_time, "time since start to randombytes_init (μs) = %.0f\n", ((double) (clock() - progStart)));
    for (int i = 0; i < repeats; i++) { // xTODO back to 10
        fprintf(fp_req, "count = %d\n", i);
        randombytes(seed, 48);
        fprintBstr(fp_req, "seed = ", seed, 48);
        mlen = 33*(i+1);
        fprintf(fp_req, "mlen = %llu\n", mlen);
        randombytes(msg, mlen);
        fprintBstr(fp_req, "msg = ", msg, mlen);
        fprintf(fp_req, "pk =\n");
        fprintf(fp_req, "sk =\n");
        fprintf(fp_req, "smlen =\n");
        fprintf(fp_req, "sm =\n\n");
    }
    fclose(fp_req);
    fprintf(fp_time, "time since start to req closing (μs) = %.0f\n", ((double) (clock() - progStart)));

    //Create the RESPONSE file based on what's in the REQUEST file
    if ( (fp_req = fopen(fn_req, "r")) == NULL ) {
        printf("PQCgenKAT ERROR: Couldn't open <%s> for read\n", fn_req);
        return KAT_FILE_OPEN_ERROR;
    }
    fprintf(fp_time, "time since start to open req readable (μs) = %.0f\n\n\n", ((double) (clock() - progStart)));

    if (debug) printf("start looping\n");
    int x = 1;
    while (1) {
        start = clock();
        if ( FindMarker(fp_req, "count = ") )
            fscanf(fp_req, "%d", &count);
        else {
            break;
        }
        fprintf(fp_rsp, "count = %d\n", count);
        fprintf(fp_time, "count = %d\n", count);
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
            printf("PQCgenKAT ERROR: unable to read 'mlen' from <%s>\n", fn_req);
            return KAT_DATA_ERROR;
        }
        fprintf(fp_rsp, "mlen = %llu\n", mlen);
        if (debug) printf("loop mlen: %llu\n", mlen);

        m = (unsigned char *)calloc(mlen+1, sizeof(unsigned char));
        m1 = (unsigned char *)calloc(mlen+CRYPTO_BYTES, sizeof(unsigned char)); // origin
//        m1 = (unsigned char *)calloc(mlen, sizeof(unsigned char));
        sm = (unsigned char *)calloc(mlen+CRYPTO_BYTES, sizeof(unsigned char)); // origin
//        sm = (unsigned char *)calloc(10000, sizeof(unsigned char));

/////////////////////////////////////////////////////////////////////
        if ( !ReadHex(fp_req, m, (int)mlen, "msg = ") ) {
            printf("PQCgenKAT ERROR: unable to read 'msg' from <%s>\n", fn_req);
            return KAT_DATA_ERROR;
        }
        fprintBstr(fp_rsp, "msg = ", m, mlen);
        if (debug) printHex("msg", msg, 30, true);
        time_prepare = ((double) (clock() - start));

        // Generate the public/private keypair
        if (debug) printf("do crypto_sign_keypair()");
        start = clock();
        if (debug) printf("-----------debug 2\n"); // xTODO
        int asd = 33*44+55+66+77*33;
        if (debug) printf("-----------debug 2 %i\n", asd); // xTODO
        if ( (ret_val = crypto_sign_keypair(pk, sk)) != 0) {
            printf("PQCgenKAT ERROR: crypto_sign_keypair returned <%d>\n", ret_val);
            return KAT_CRYPTO_FAILURE;
        }
        if (debug) printf("-----------debug 3\n"); // xTODO
        time_keypair = ((double) (clock() - start));
        if (debug) printf(" (took: %.0f μs)\n", time_keypair);
        fprintBstr(fp_rsp, "pk = ", pk, CRYPTO_PUBLICKEYBYTES);
        fprintBstr(fp_rsp, "sk = ", sk, CRYPTO_SECRETKEYBYTES);
        if (debug) { printHex("pk", pk, 30, true); printHex("sk", sk, 30, true); }

        // signing
        // if encrypt use randombytes then we need to reinit for same results as _enc run
        randombytes_init(seed, NULL, 256);
        if (debug) printf("do crypto_sign()");
        start = clock();
        if ( (ret_val = crypto_sign(sm, &smlen, m, mlen, sk)) != 0) {
            printf("PQCgenKAT ERROR: crypto_sign returned <%d>\n", ret_val);
            return KAT_CRYPTO_FAILURE;
        }
        time_sign = ((double) (clock() - start));
        if (debug) printf(" (took: %.0f μs)\n", time_sign);

        fprintf(fp_rsp, "smlen = %llu\n", smlen);
        fprintBstr(fp_rsp, "sm = ", sm, smlen);
        fprintf(fp_rsp, "\n");
        if (debug) {
            printf("smlen: %llu\n", smlen);
            printHex("sm", sm, 30, true);
        }

        // verify signing
        if (debug) printf("do crypto_sign_open()");
        start = clock();
        if ( (ret_val = crypto_sign_open(m1, &mlen1, sm, smlen, pk)) != 0) {
            printf("PQCgenKAT ERROR: crypto_sign_open returned <%d>\n", ret_val);
            return KAT_CRYPTO_FAILURE;
        }
        time_verify = ((double) (clock() - start));
        if (debug) printf(" (took: %.0f μs)\n", time_verify);

        // write time measure to file
        fprintf(fp_time, "prepare (μs) = %.0f\n", time_prepare);
        fprintf(fp_time, "crypto_sign_keypair (μs) = %.0f\n", time_keypair);
        fprintf(fp_time, "crypto_sign (μs) = %.0f\n", time_sign);
        fprintf(fp_time, "crypto_sign_open (μs) = %.0f\n", time_verify);
        fprintf(fp_time, "\n");
        fprintf(fp_rsp, "\n");

        if ( mlen != mlen1 ) {
            printf("PQCgenKAT ERROR: crypto_sign_open returned bad 'mlen': Got <%llu>, expected <%llu>\n", mlen1, mlen);
            return KAT_CRYPTO_FAILURE;
        }

        if ( memcmp(m, m1, mlen) ) {
            printf("PQCgenKAT ERROR: crypto_sign_open returned bad 'm' value\n");
            return KAT_CRYPTO_FAILURE;
        }
        fflush(fp_rsp);
        fflush(fp_time);
        free(m);
        free(m1);
        free(sm);

    }
    if (debug) printf("finish looping\n");

    fseek(fp_time, strlen(CRYPTO_ALGNAME) + 4, SEEK_SET);
    fprintf(fp_time, "time from start to end (μs) = %.0f", ((double) (clock() - progStart)));

// from GUI original genKAT
//free(pk);
//free(sk);

    fclose(fp_req);
    fclose(fp_rsp);
    fclose(fp_time);

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
    *s = '\0';
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

