//
//  PQCgenKAT_kem.c
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
#define MAX_PRINT           80

#ifndef CRYPTO_ALGNAME
#define CRYPTO_ALGNAME "unset"
#endif

int		FindMarker(FILE *infile, const char *marker);
int		ReadHex(FILE *infile, unsigned char *A, int Length, const char *str);
void	fprintBstr(FILE *fp, const char *S, unsigned char *A, unsigned long long L);
void    hex_to_bin(size_t size, unsigned char *dest, const char *input);
void    printHex(const char *fieldname, unsigned char *hexstring, int printamount, int maxamount);

// global variable
bool    debug = false;

int
main(int argc, char* argv[])
{
    char                fn_req[32], fn_rsp[32], fn_time[32];
    FILE                *fp_req, *fp_rsp, *fp_time;
    unsigned char       seed[48], entropy_input[48];
    int                 count, ret_val, repeats = 10;
    clock_t             start, progStart;
    double              time_keypair, time_enc, time_dec, time_prepare;

    // https://stackoverflow.com/questions/30034215/segmentation-fault-on-large-array-declaration
    unsigned char       *ct, *sk, *pk, *ss, *ss1; // replaced because segmentation fault of large array declaration

    printf(" ");
    if (argc > 1) {
        char *output;
        // amount of repeats for req file
        repeats = atoi(argv[1]);
        if (argc > 2 && strcmp(argv[2], "1") == 0) {
            debug = true;
            printf("start main(argc: %i) %s\n", argc, argv[0]);
            for (int i = 0; i < argc; i++) {
                printf("argv[%d]: %s\n", i, argv[i]);
            }
            printf("repeats: %i\n", repeats);
        }
    }

    progStart = clock();

    // Create the REQUEST file
    sprintf(fn_req, "PQCkemKAT.req");
    if ( (fp_req = fopen(fn_req, "w")) == NULL ) {
        printf("PQCgenKAT ERROR: Couldn't open <%s> for write\n", fn_req);
        return KAT_FILE_OPEN_ERROR;
    }
    sprintf(fn_rsp, "PQCkemKAT.rsp");
    if ( (fp_rsp = fopen(fn_rsp, "w")) == NULL ) {
        printf("PQCgenKAT ERROR: Couldn't open <%s> for write\n", fn_rsp);
        return KAT_FILE_OPEN_ERROR;
    }
    sprintf(fn_time, "PQCkemKAT.time");
    if ( (fp_time = fopen(fn_time, "w")) == NULL ) {
        printf("PQCgenKAT ERROR: Couldn't open <%s> for write\n", fn_time);
        return KAT_FILE_OPEN_ERROR;
    }
    fprintf(fp_rsp, "# %s\n\n", CRYPTO_ALGNAME);
    fprintf(fp_time, "# %s\n\n", CRYPTO_ALGNAME);
    fprintf(fp_time, "reserved for full time output                                                  \n");
    fprintf(fp_time, "time since start to open rsp file (μs) = %.0f\n", ((double) (clock() - progStart)));

    for (int i=0; i<48; i++)
        entropy_input[i] = i;

    randombytes_init(entropy_input, NULL, 256);
    fprintf(fp_time, "time since start to randombytes_init (μs) = %.0f\n", ((double) (clock() - progStart)));
    for (int i=0; i<repeats; i++) {
        fprintf(fp_req, "count = %d\n", i);
        randombytes(seed, 48);
        fprintBstr(fp_req, "seed = ", seed, 48);
        fprintf(fp_req, "pk =\n");
        fprintf(fp_req, "sk =\n");
        fprintf(fp_req, "keygen (s) =\n");
        fprintf(fp_req, "ct =\n");
        fprintf(fp_req, "ss =\n\n");
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

        ct = (unsigned char *) calloc(CRYPTO_CIPHERTEXTBYTES, sizeof(unsigned char));
        pk = (unsigned char *) calloc(CRYPTO_PUBLICKEYBYTES, sizeof(unsigned char));
        sk = (unsigned char *) calloc(CRYPTO_SECRETKEYBYTES, sizeof(unsigned char));
        ss = (unsigned char *) calloc(CRYPTO_BYTES, sizeof(unsigned char));
        ss1 = (unsigned char *) calloc(CRYPTO_BYTES, sizeof(unsigned char));

        if ( !ReadHex(fp_req, seed, 48, "seed = ") ) {
            printf("PQCgenKAT ERROR: unable to read 'seed' from <%s>\n", fn_req);
            return KAT_DATA_ERROR;
        }
        fprintBstr(fp_rsp, "seed = ", seed, 48);
        randombytes_init(seed, NULL, 256);
        time_prepare = ((double) (clock() - start));

        // Generate the public/private keypair
        if (debug) printf("do crypto_kem_keypair()");
        start = clock();
        if ( (ret_val = crypto_kem_keypair(pk, sk)) != 0) {
            printf("PQCgenKAT ERROR: crypto_kem_keypair returned <%d>\n", ret_val);
            return KAT_CRYPTO_FAILURE;
        }
        time_keypair = ((double) (clock() - start));
        if (debug) printf(" (took: %.0f μs)\n", time_keypair);

        fprintBstr(fp_rsp, "pk = ", pk, CRYPTO_PUBLICKEYBYTES);
        fprintBstr(fp_rsp, "sk = ", sk, CRYPTO_SECRETKEYBYTES);

        // encoding
        randombytes_init(seed, NULL, 256);
        if (debug) printf("do crypto_kem_enc()");
        start = clock();
        if ( (ret_val = crypto_kem_enc(ct, ss, pk)) != 0) {
            printf("PQCgenKAT ERROR: crypto_kem_enc returned <%d>\n", ret_val);
            return KAT_CRYPTO_FAILURE;
        }
        time_enc = ((double) (clock() - start));
        if (debug) printf(" (took: %.0f μs)\n", time_enc);

        fprintBstr(fp_rsp, "ct = ", ct, CRYPTO_CIPHERTEXTBYTES);
        fprintBstr(fp_rsp, "ss = ", ss, CRYPTO_BYTES);

        // decoding
        randombytes_init(seed, NULL, 256);
        if (debug) printf("do crypto_kem_dec()");
        start = clock();
        if ( (ret_val = crypto_kem_dec(ss1, ct, sk)) != 0) {
            printf("PQCgenKAT ERROR: crypto_kem_dec returned <%d>\n", ret_val);
            return KAT_CRYPTO_FAILURE;
        }
        time_dec = ((double) (clock() - start));
        if (debug) printf(" (took: %.0f μs)\n", time_dec);

        // write time measure to file
        fprintf(fp_time, "prepare (μs) = %.0f\n", time_prepare);
        fprintf(fp_time, "crypto_kem_keypair (μs) = %.0f\n", time_keypair);
        fprintf(fp_time, "crypto_kem_enc (μs) = %.0f\n", time_enc);
        fprintf(fp_time, "crypto_kem_dec (μs) = %.0f\n", time_dec);
        fprintf(fp_time, "\n");
        fprintf(fp_rsp, "\n");

        if ( memcmp(ss, ss1, CRYPTO_BYTES) ) {
            printf("PQCgenKAT ERROR: crypto_kem_dec returned bad 'ss' value\n");
            return KAT_CRYPTO_FAILURE;
        }

        free(ct);
        free(pk);
        free(sk);
        free(ss);
        free(ss1);
    }
    if (debug) printf("finish looping\n");

    fseek(fp_time, strlen(CRYPTO_ALGNAME) + 4, SEEK_SET);
    fprintf(fp_time, "time from start to end (μs) = %.0f", ((double) (clock() - progStart)));

    fclose(fp_req);
    fclose(fp_rsp);
    fclose(fp_time);

    return KAT_SUCCESS;
}

void printHex(const char *fieldname, unsigned char *hexstring, int printamount, int maxamount) {
    printf("%s: ", fieldname);
    unsigned char *cp = hexstring;
    int amount = printamount > maxamount ? maxamount : printamount;
    for (int i = 0; i < amount; i++) printf("%02X", *cp++);
    if (printamount > maxamount) printf("...");
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
ReadHex(FILE *infile, unsigned char *A, int Length, const char *str) {
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
//    if (debug) printf("ReadHex line length: %llu, size: %llu\n", strlen(line), size1);
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
//    if (debug) printf(" (hex_to_bin i: %llu)", i);
}

void
fprintBstr(FILE *fp, const char *S, unsigned char *A, unsigned long long L)
{
//    clock_t start = clock();
	unsigned long long  i;

	fprintf(fp, "%s", S);

	for ( i=0; i<L; i++ )
		fprintf(fp, "%02X", A[i]);

	if ( L == 0 )
		fprintf(fp, "00");

	fprintf(fp, "\n");
//    if (debug) printf("time passed in fprintBstr (μs) = %.0f\n", ((double) (clock() - start)));
}

