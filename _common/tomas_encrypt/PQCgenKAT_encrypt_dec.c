//
//  PQCgenKAT_encrypt.c
//
//  Created by Bassham, Lawrence E (Fed) on 8/29/17.
//  Copyright © 2017 Bassham, Lawrence E (Fed). All rights reserved.
//
// changed by Tomas Antal for heap&stack measurement by valgrind (massif)
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
    char                fn_rsp[32], fn_rsp_origin[32];
    FILE                *fp_rsp, *fp_rsp_origin;
    unsigned char       *m, *c, *m1;
    unsigned long long  mlen, clen, mlen1;
    int                 count, ret_val;

    unsigned char       *sk; // replaced because segmentation fault of large array declaration

    printf(" ");
    if (argc > 1 && strcmp(argv[1], "1") == 0) {
        debug = true;
        printf("start main(argc: %i) %s\n", argc, argv[0]);
        for (int i = 0; i < argc; i++) {
            printf("argv[%d]: %s\n", i, argv[i]);
        }
    }

    sk = (unsigned char *) calloc(CRYPTO_SECRETKEYBYTES, sizeof(unsigned char));

    sprintf(fn_rsp, "PQCencryptKAT_dec.rsp");
    if ( (fp_rsp = fopen(fn_rsp, "w")) == NULL ) {
        printf("PQCgenKAT ERROR: Couldn't open <%s> for write\n", fn_rsp);
        return KAT_FILE_OPEN_ERROR;
    }
    fprintf(fp_rsp, "# %s\n\n", CRYPTO_ALGNAME);

    //Create the RESPONSE file based on what's in the REQUEST file
    sprintf(fn_rsp_origin, "PQCencryptKAT.rsp");
    if ( (fp_rsp_origin = fopen(fn_rsp_origin, "r")) == NULL ) {
        printf("PQCgenKAT ERROR: Couldn't open <%s> for read\n", fn_rsp_origin);
        return KAT_FILE_OPEN_ERROR;
    }

    if (debug) printf("start looping\n");
    while (1) {
        if ( FindMarker(fp_rsp_origin, "count = "))
            fscanf(fp_rsp_origin, "%d", &count);
        else {
            break;
        }
        fprintf(fp_rsp, "count = %d\n", count);
        if (debug) printf("loop count: %d\n", count);

        if ( FindMarker(fp_rsp_origin, "mlen = ") )
            fscanf(fp_rsp_origin, "%llu", &mlen);
        else {
            printf("PQCgenKAT ERROR: unable to read 'mlen' from <%s>\n", fn_rsp_origin);
            return KAT_DATA_ERROR;
        }

        // prepare decode
        ReadHex(fp_rsp_origin, sk, CRYPTO_SECRETKEYBYTES, "sk = ");
        if (debug) printHex("sk", sk, CRYPTO_SECRETKEYBYTES, MAX_PRINT);

        if ( FindMarker(fp_rsp_origin, "clen = ") )
            fscanf(fp_rsp_origin, "%llu", &clen);
        else {
            printf("ERROR: unable to read 'clen' from <%s>\n", fn_rsp_origin);
            return KAT_DATA_ERROR;
        }
        if (debug) printf("clen: %llu\n", clen);

        m1 = (unsigned char *)calloc(mlen, sizeof(unsigned char));
        c = (unsigned char *)calloc(clen, sizeof(unsigned char));

        ReadHex(fp_rsp_origin, c, clen, "c = ");
        if (debug) printHex("c", c, clen, MAX_PRINT);

        if ( (ret_val = crypto_encrypt_open(m1, &mlen1, c, clen, sk)) != 0) {
            printf("crypto_encrypt_open returned <%d>\n", ret_val);
            return KAT_CRYPTO_FAILURE;
        }
        // name it as in base KAT "msg" - for verify
        fprintBstr(fp_rsp, "msg = ", m1, mlen1);
        fprintf(fp_rsp, "\n");


        free(m1);

    }

    fclose(fp_rsp);
    fclose(fp_rsp_origin);

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

    free(line);
    line = NULL;

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

