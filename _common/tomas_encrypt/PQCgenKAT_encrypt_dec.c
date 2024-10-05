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
void    printHex(char *fieldname, unsigned char *hexstring, int printamount, int maxamount);

// global variable
bool    debug = false;

int
main(int argc, char* argv[])
{
    char                fn_rsp[32], fn_rsp_origin[32];
    FILE                *fp_rsp, *fp_rsp_origin;
    unsigned char       seed[48];
    unsigned char       msg[3300];
    unsigned char       entropy_input[48];
    unsigned char       *m, *c, *m1;
    unsigned long long  mlen, clen, mlen1;
    int                 count;
    unsigned char       pk[CRYPTO_PUBLICKEYBYTES], sk[CRYPTO_SECRETKEYBYTES];
    int                 ret_val;
//    int i, j;

    if ( argc > 1 && strcmp(argv[1], "1") == 0) {
        debug = true;
        printf("start main PQCgenKAT_encrypt_dec (argc: %i)\n", argc);
        if (debug) {
            for (int i = 0; i < argc; i++) {
                printf("argv[%d]: %s\n", i, argv[i]);
            }
        }
    }

    /* Create the REQUEST file */
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
//    sprintf(fn_time, "PQCencryptKAT.time");
//    if ( (fp_time = fopen(fn_time, "w")) == NULL ) {
//        printf("PQCgenKAT ERROR: Couldn't open <%s> for write\n", fn_time);
//        return KAT_FILE_OPEN_ERROR;
//    }
    fprintf(fp_rsp, "# %s\n\n", CRYPTO_ALGNAME);
//    fprintf(fp_time, "# %s\n\n", CRYPTO_ALGNAME);
//    fprintf(fp_time, "time since start to open rsp file (μs) = %.0f\n", ((double) (clock() - start)));

//    for (int i=0; i<48; i++)
//        entropy_input[i] = i;

//    randombytes_init(entropy_input, NULL, 256);
//    fprintf(fp_time, "time since start to randombytes_init (μs) = %.0f\n", ((double) (clock() - start)));
//    for (i=0; i<1; i++) {
//        for (j=0; j<5; j++) {
//            fprintf(fp_req, "count = %d\n", i*25+j);
//            randombytes(seed, 48);
//            fprintBstr(fp_req, "seed = ", seed, 48);
//            mlen = 16+i*8;
//            fprintf(fp_req, "mlen = %lld\n", mlen);
//            randombytes(msg, mlen);
//            fprintBstr(fp_req, "msg = ", msg, mlen);
//            fprintf(fp_req, "pk =\n");
//            fprintf(fp_req, "sk =\n");
//            fprintf(fp_req, "clen =\n");
//            fprintf(fp_req, "c =\n\n");
//        }
//    }
//    fclose(fp_req);
//    fprintf(fp_time, "time since start to req closing (μs) = %.0f\n", ((double) (clock() - start)));

    //Create the RESPONSE file based on what's in the REQUEST file
    sprintf(fn_rsp_origin, "PQCencryptKAT.rsp");
    if ( (fp_rsp_origin = fopen(fn_rsp_origin, "r")) == NULL ) {
        printf("PQCgenKAT ERROR: Couldn't open <%s> for read\n", fn_rsp_origin);
        return KAT_FILE_OPEN_ERROR;
    }

//    fprintf(fp_time, "time since start to open req readable (μs) = %.0f\n", ((double) (clock() - start)));

//    fprintf(fp_time, "\n");
    if (debug) printf("start looping\n");
    while (1) {
//        start = clock();
        if ( FindMarker(fp_rsp_origin, "count = "))
            fscanf(fp_rsp_origin, "%d", &count);
        else {
            break;
        }
        fprintf(fp_rsp, "count = %d\n", count);
//        fprintf(fp_time, "count = %d\n", count);
        if (debug) printf("loop count: %d\n", count);

//        if ( !ReadHex(fp_rsp_origin, seed, 48, "seed = ") ) {
//            printf("PQCgenKAT ERROR: unable to read 'seed' from <%s>\n", fn_rsp_origin);
//            return KAT_DATA_ERROR;
//        }
//        fprintBstr(fp_rsp, "seed = ", seed, 48);
//        randombytes_init(seed, NULL, 256);

        if ( FindMarker(fp_rsp_origin, "mlen = ") )
            fscanf(fp_rsp_origin, "%llu", &mlen);
        else {
            printf("PQCgenKAT ERROR: unable to read 'mlen' from <%s>\n", fn_rsp_origin);
            return KAT_DATA_ERROR;
        }
//        fprintf(fp_rsp, "mlen = %llu\n", mlen);
        
//        m = (unsigned char *)calloc(mlen, sizeof(unsigned char));
//        m1 = (unsigned char *)calloc(mlen+CRYPTO_BYTES, sizeof(unsigned char));

//        if ( !ReadHex(fp_rsp_origin, m, (int)mlen, "msg = ") ) {
//            printf("ERROR: unable to read 'msg' from <%s>\n", fn_rsp_origin);
//            return KAT_DATA_ERROR;
//        }
//        fprintBstr(fp_rsp, "msg = ", m, mlen);
//        time_prepare = ((double) (clock() - start));

        // Generate the public/private keypair
//        start = clock();
//        if ( (ret_val = crypto_encrypt_keypair(pk, sk)) != 0) {
//            printf("PQCgenKAT ERROR: crypto_encrypt_keypair returned <%d>\n", ret_val);
//            return KAT_CRYPTO_FAILURE;
//        }
//        time_keypair = ((double) (clock() - start));
//        fprintBstr(fp_rsp, "pk = ", pk, CRYPTO_PUBLICKEYBYTES);
//        fprintBstr(fp_rsp, "sk = ", sk, CRYPTO_SECRETKEYBYTES);

        // prepare decode
//        ReadHex(fp_rsp_origin, pk, CRYPTO_PUBLICKEYBYTES, "pk = ");
//        fprintBstr(fp_rsp, "pk = ", pk, CRYPTO_PUBLICKEYBYTES);

        // encoding
//        randombytes_init(seed, NULL, 256);
//        start = clock();
//        if ( (ret_val = crypto_encrypt(c, &clen, m, mlen, pk)) != 0) {
//            printf("PQCgenKAT ERROR: crypto_encrypt returned <%d>\n", ret_val);
//            return KAT_CRYPTO_FAILURE;
//        }
//        time_enc = ((double) (clock() - start));
//        fprintf(fp_rsp, "clen = %llu\n", clen);
//        fprintBstr(fp_rsp, "c = ", c, clen);
//        fprintf(fp_rsp, "\n");

        // prepare decode
        ReadHex(fp_rsp_origin, sk, CRYPTO_SECRETKEYBYTES, "sk = ");
        if (debug) printHex("sk", sk, CRYPTO_SECRETKEYBYTES, 60);

        if ( FindMarker(fp_rsp_origin, "clen = ") )
            fscanf(fp_rsp_origin, "%llu", &clen);
        else {
            printf("ERROR: unable to read 'clen' from <%s>\n", fn_rsp_origin);
            return KAT_DATA_ERROR;
        }
        if (debug) printf("clen: %llu\n", clen);

        m1 = (unsigned char *)calloc(mlen, sizeof(unsigned char));
        c = (unsigned char *)calloc(clen, sizeof(unsigned char));

//        FindMarker(fp_rsp_origin, "c = ");
//        clen = CRYPTO_CIPHERTEXTBYTES;
        // ReadHex buggy using it one after the other,

        ReadHex(fp_rsp_origin, c, clen, "c = ");
//        start = clock();
        if (debug) printHex("c", c, clen, 60);
//        c = ct + '\0';
//        if (debug) printHex(" c", c, clen, 60);
//        m1[0] = 'A';
//        if (debug) printHex("m1", m1, mlen1, 60);
//        if (debug) printf("m1: %s\n", m1);

//        unsigned char m1[clen+1];

        if ( (ret_val = crypto_encrypt_open(m1, &mlen1, c, clen, sk)) != 0) {
            printf("crypto_encrypt_open returned <%d>\n", ret_val);
            return KAT_CRYPTO_FAILURE;
        }
        // name it as in base KAT "msg" - for verify
        fprintBstr(fp_rsp, "msg = ", m1, mlen1);
        fprintf(fp_rsp, "\n");
//        printf("m1: %s\n", m1);
//        time_dec = ((double) (clock() - start));

        // write time measure to file
//        fprintf(fp_time, "prepare (μs) = %.0f\n", time_prepare);
//        fprintf(fp_time, "crypto_encrypt_keypair (μs) = %.0f\n", time_keypair);
//        fprintf(fp_time, "crypto_encrypt_enc (μs) = %.0f\n", time_enc);
//        fprintf(fp_time, "crypto_encrypt_dec (μs) = %.0f\n", time_dec);
//        fprintf(fp_time, "\n");
        
//        if ( mlen != mlen1 ) {
//            printf("PQCgenKAT ERROR: crypto_encrypt_open returned bad 'mlen': Got <%llu>, expected <%llu>\n", mlen1, mlen);
//            return KAT_CRYPTO_FAILURE;
//        }
//
//        if ( memcmp(m, m1, mlen) ) {
//            printf("PQCgenKAT ERROR: crypto_encrypt_open returned bad 'm' value\n");
//            return KAT_CRYPTO_FAILURE;
//        }
        
//        free(m);
        free(m1);
//        free(ct);

    }

//    fclose(fp_req);
    fclose(fp_rsp);
//    fclose(fp_time);
    fclose(fp_rsp_origin);

    return KAT_SUCCESS;
}

void printHex(char *fieldname, unsigned char *hexstring, int printamount, int maxamount) {
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

