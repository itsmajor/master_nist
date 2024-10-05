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

#define    MAX_MARKER_LEN        50
#define KAT_SUCCESS          0
#define KAT_FILE_OPEN_ERROR -1
#define KAT_DATA_ERROR      -3
#define KAT_CRYPTO_FAILURE  -4

#ifndef CRYPTO_ALGNAME
#define CRYPTO_ALGNAME = "unset"
#endif

int     FindMarker(FILE *infile, const char *marker);
int     ReadHex(FILE *infile, unsigned char *A, int Length, char *str);
void    fprintBstr(FILE *fp, char *S, unsigned char *A, unsigned long long L);
void    hex_to_bin(size_t size, unsigned char *dest, const char *input);
void    printHex(char *fieldname, char *hexstring, int printamount, int maxamount);

// global variable
bool debug = false;

int
main(int argc, char *argv[]) {
    char fn_rsp[32], fn_rsp_origin[32];
    FILE *fp_rsp, *fp_rsp_origin;
    unsigned char seed[48];
    unsigned char msg[3300];
    unsigned char entropy_input[48];
    unsigned char *m, *c, *m1;
    unsigned long long mlen, clen, mlen1;
    int count;
    unsigned char pk[CRYPTO_PUBLICKEYBYTES], sk[CRYPTO_SECRETKEYBYTES];
    int ret_val;
    int i, j;

    if ( argc > 1 && strcmp(argv[1], "1") == 0) {
        debug = true;
        printf("start main PQCgenKAT_encrypt_enc (argc: %i)\n", argc);
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
    sprintf(fn_rsp, "PQCencryptKAT_enc.rsp");
    if ((fp_rsp = fopen(fn_rsp, "w")) == NULL) {
        printf("PQCgenKAT ERROR: Couldn't open <%s> for write\n", fn_rsp);
        return KAT_FILE_OPEN_ERROR;
    }
    fprintf(fp_rsp, "# %s\n\n", CRYPTO_ALGNAME);

//    for (int i=0; i<48; i++)
//        entropy_input[i] = i;

//    randombytes_init(entropy_input, NULL, 256);
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

    //Create the RESPONSE file based on what's in the REQUEST file
    sprintf(fn_rsp_origin, "PQCencryptKAT.rsp");
    if ((fp_rsp_origin = fopen(fn_rsp_origin, "r")) == NULL) {
        printf("PQCgenKAT ERROR: Couldn't open <%s> for read\n", fn_rsp_origin);
        return KAT_FILE_OPEN_ERROR;
    }

    if (debug) printf("start looping\n");
    int x = 0;
    while (1) {
        if (++x == 10000) printf("while loop at 10000");

        if (FindMarker(fp_rsp_origin, "count = "))
            fscanf(fp_rsp_origin, "%d", &count);
        else {
            break;
        }
        fprintf(fp_rsp, "count = %d\n", count);
        if (debug) printf("loop count: %d\n", count);

        if (!ReadHex(fp_rsp_origin, seed, 48, "seed = ")) {
            printf("PQCgenKAT ERROR: unable to read 'seed' from <%s>\n", fn_rsp_origin);
            return KAT_DATA_ERROR;
        }
//        fprintBstr(fp_rsp, "seed = ", seed, 48);
        randombytes_init(seed, NULL, 256);
        if (debug) printHex("randombytes_init seed: ", seed, 48, 48);

        if (FindMarker(fp_rsp_origin, "mlen = "))
            fscanf(fp_rsp_origin, "%llu", &mlen);
        else {
            printf("PQCgenKAT ERROR: unable to read 'mlen' from <%s>\n", fn_rsp_origin);
            return KAT_DATA_ERROR;
        }
//        fprintf(fp_rsp, "mlen = %llu\n", mlen);
        if (debug) printf("mlen: %llu\n", mlen);

        m = (unsigned char *) calloc(mlen, sizeof(unsigned char));
//        m1 = (unsigned char *) calloc(mlen+CRYPTO_BYTES, sizeof(unsigned char));
        c = (unsigned char *) calloc(mlen + CRYPTO_BYTES, sizeof(unsigned char));
        if (debug) printf("calloc (m, c) done\n");

        if (!ReadHex(fp_rsp_origin, m, (int) mlen, "msg = ")) {
            printf("ERROR: unable to read 'msg' from <%s>\n", fn_rsp_origin);
            return KAT_DATA_ERROR;
        }
//        fprintBstr(fp_rsp, "msg = ", m, mlen);
        if (debug) printHex("m", m, mlen, 60);


///////////////////////////////////////////////

//         Generate the public/private keypair
//        if ( (ret_val = crypto_encrypt_keypair(pk, sk)) != 0) {
//            printf("PQCgenKAT ERROR: crypto_encrypt_keypair returned <%d>\n", ret_val);
//            return KAT_CRYPTO_FAILURE;
//        }
//        fprintBstr(fp_rsp, "pk = ", pk, CRYPTO_PUBLICKEYBYTES);
//        fprintBstr(fp_rsp, "sk = ", sk, CRYPTO_SECRETKEYBYTES);

        // prepare decode
//        FindMarker(fp_rsp_origin, "pk = ");
        ReadHex(fp_rsp_origin, pk, CRYPTO_PUBLICKEYBYTES, "pk = ");
        if (debug) printHex("pk", pk, CRYPTO_PUBLICKEYBYTES, 60);
//        fprintBstr(fp_rsp, "pk = ", pk, CRYPTO_PUBLICKEYBYTES);

        // encoding

//        if (debug) {
//            printf("PK: ");
//            char *cp = pk;
//            for (int i = 0; i < 30; i++) printf("%02X", *cp++);
//            printf("\nm: ");
//            char* cp2 = m;
//            for (int i = 0; *cp2 != '\0' && i < 30; i++) printf("%02X", *cp2++);
//            printf("\n");
//        }

        if ((ret_val = crypto_encrypt(c, &clen, m, mlen, pk)) != 0) {
            printf("PQCgenKAT ERROR: crypto_encrypt returned <%d>\n", ret_val);
            return KAT_CRYPTO_FAILURE;
        }
        if (debug) printf("clen x: %llu\n", clen);

        fprintf(fp_rsp, "clen = %llu\n", clen);
        fprintBstr(fp_rsp, "c = ", c, clen);
        fprintf(fp_rsp, "\n");
        fflush(fp_rsp);

//        if ( (ret_val = crypto_encrypt_open(m1, &mlen1, c, clen, sk)) != 0) {
//            printf("crypto_encrypt_open returned <%d>\n", ret_val);
//            return KAT_CRYPTO_FAILURE;
//        }

//        if ( mlen != mlen1 ) {
//            printf("PQCgenKAT ERROR: crypto_encrypt_open returned bad 'mlen': Got <%llu>, expected <%llu>\n", mlen1, mlen);
//            return KAT_CRYPTO_FAILURE;
//        }
//
//        if ( memcmp(m, m1, mlen) ) {
//            printf("PQCgenKAT ERROR: crypto_encrypt_open returned bad 'm' value\n");
//            return KAT_CRYPTO_FAILURE;
//        }

        free(m);
//        free(m1);
        free(c);

    }

//    fclose(fp_req);
    fclose(fp_rsp);
    fclose(fp_rsp_origin);

    return KAT_SUCCESS;
}

void printHex(char *fieldname, char *hexstring, int printamount, int maxamount) {
    printf("%s: ", fieldname);
    char *cp = hexstring;
    int amount = printamount > maxamount ? maxamount : printamount;
    for (int i = 0; i < amount; i++) printf("%02X", *cp++);
    if (printamount > maxamount) printf("...");
    printf("\n");
}

//
// ALLOW TO READ HEXADECIMAL ENTRY (KEYS, DATA, TEXT, etc.)
//
int
FindMarker(FILE *infile, const char *marker) {
    char line[MAX_MARKER_LEN];
    int i, len;
    int curr_line;

    len = (int) strlen(marker);
    if (len > MAX_MARKER_LEN - 1)
        len = MAX_MARKER_LEN - 1;

    for (i = 0; i < len; i++) {
        curr_line = fgetc(infile);
        line[i] = curr_line;
        if (curr_line == EOF)
            return 0;
    }
    line[len] = '\0';

//    int x = 0;
    while (1) {
//        if (++x == 10000) printf("************ FindMarker loop at 10000 *****************");
        if (!strncmp(line, marker, len))
            return 1;

        for (i = 0; i < len - 1; i++)
            line[i] = line[i + 1];
        curr_line = fgetc(infile);
        line[len - 1] = curr_line;
        if (curr_line == EOF)
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
fprintBstr(FILE *fp, char *S, unsigned char *A, unsigned long long L) {
    unsigned long long i;

    fprintf(fp, "%s", S);

    for (i = 0; i < L; i++)
        fprintf(fp, "%02X", A[i]);

    if (L == 0)
        fprintf(fp, "00");

    fprintf(fp, "\n");
}

