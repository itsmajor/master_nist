//
//  PQCgenKAT_kem.c
//
//  Created by Bassham, Lawrence E (Fed) on 8/29/17.
//  Copyright © 2017 Bassham, Lawrence E (Fed). All rights reserved.
//
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include "../NIST/rng.h"
#include "api.h"
#include <time.h>

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

int
main()
{
    char                fn_rsp[32], fn_rsp_origin[32];
    FILE                *fp_rsp, *fp_rsp_origin;
    unsigned char       seed[48];
//    unsigned char       entropy_input[48];
    unsigned char       ct[CRYPTO_CIPHERTEXTBYTES], ss[CRYPTO_BYTES];
    int                 count;
    unsigned char       pk[CRYPTO_PUBLICKEYBYTES], sk[CRYPTO_SECRETKEYBYTES];
    int                 ret_val;
    clock_t start;
    double time_enc, time_prepare;

    // Create the REQUEST file
//    sprintf(fn_req, "PQCkemKAT_%d.req", CRYPTO_SECRETKEYBYTES);
//    sprintf(fn_req, "PQCkemKAT_dec.req");
//    if ( (fp_req = fopen(fn_req, "w")) == NULL ) {
//        printf("PQCgenKAT ERROR: Couldn't open <%s> for write\n", fn_req);
//        return KAT_FILE_OPEN_ERROR;
//    }
//    sprintf(fn_rsp, "PQCkemKAT_%d.rsp", CRYPTO_SECRETKEYBYTES);
    sprintf(fn_rsp, "PQCkemKAT_enc.rsp");
    if ( (fp_rsp = fopen(fn_rsp, "w")) == NULL ) {
        printf("PQCgenKAT ERROR: Couldn't open <%s> for write\n", fn_rsp);
        return KAT_FILE_OPEN_ERROR;
    }

//    for (int i=0; i<48; i++)
//        entropy_input[i] = i;

//    randombytes_init(entropy_input, NULL, 256);
//    for (int i=0; i<10; i++) {
//        fprintf(fp_req, "count = %d\n", i);
//        randombytes(seed, 48);
//        fprintBstr(fp_req, "seed = ", seed, 48);
//        fprintf(fp_req, "pk =\n");
//        fprintf(fp_req, "sk =\n");
//        fprintf(fp_req, "keygen (s) =\n");
//        fprintf(fp_req, "ct =\n");
//        fprintf(fp_req, "ss =\n\n");
//    }
//    fclose(fp_req);

    //Create the RESPONSE file based on what's in the REQUEST file
//    if ( (fp_req = fopen(fn_req, "r")) == NULL ) {
//        printf("PQCgenKAT ERROR: Couldn't open <%s> for read\n", fn_req);
//        return KAT_FILE_OPEN_ERROR;
//    }

    sprintf(fn_rsp_origin, "PQCkemKAT.rsp");
    if ( (fp_rsp_origin = fopen(fn_rsp_origin, "r")) == NULL ) {
        printf("PQCgenKAT ERROR: Couldn't open <%s> for read\n", fp_rsp_origin);
        return KAT_FILE_OPEN_ERROR;
    }

    fprintf(fp_rsp, "# %s\n\n", CRYPTO_ALGNAME);
    while (1) {
        start = clock();
        if ( FindMarker(fp_rsp_origin, "count = ") )
            fscanf(fp_rsp_origin, "%d", &count);
        else {
            break;
        }
        fprintf(fp_rsp, "count = %d\n", count);

//        if ( !ReadHex(fp_req, seed, 48, "seed = ") ) {
//            printf("PQCgenKAT ERROR: unable to read 'seed' from <%s>\n", fn_req);
//            return KAT_DATA_ERROR;
//        }
//        fprintBstr(fp_rsp, "seed = ", seed, 48);
//        randombytes_init(seed, NULL, 256);

        if ( !ReadHex(fp_rsp_origin, seed, 48, "seed = ") ) {
            printf("PQCgenKAT ERROR: unable to read 'seed' from <%s>\n", fn_rsp_origin);
            return KAT_DATA_ERROR;
        }
        fprintBstr(fp_rsp, "seed = ", seed, 48);
        randombytes_init(seed, NULL, 256);
        time_prepare = ((double) (clock() - start));

//        ret_val = crypto_kem_keypair(pk, sk);

        // Generate the public/private keypair
//        start = clock();
//        if ( (ret_val = crypto_kem_keypair(pk, sk)) != 0) {
//            printf("PQCgenKAT ERROR: crypto_kem_keypair returned <%d>\n", ret_val);
//            return KAT_CRYPTO_FAILURE;
//        }
//        end = clock();
//        time_keypair = ((double) (end - start));
//        fprintBstr(fp_rsp, "pk = ", pk, CRYPTO_PUBLICKEYBYTES);
//        fprintBstr(fp_rsp, "sk = ", sk, CRYPTO_SECRETKEYBYTES);

        // prepare decode
        ReadHex(fp_rsp_origin, pk, CRYPTO_PUBLICKEYBYTES, "pk = ");
//        ReadHex(fp_rsp_origin, ct, CRYPTO_CIPHERTEXTBYTES, "ct = ");
        fprintBstr(fp_rsp, "pk = ", pk, CRYPTO_PUBLICKEYBYTES);
//        fprintBstr(fp_rsp, "ct = ", ct, CRYPTO_CIPHERTEXTBYTES);

        // encoding
        start = clock();
        if ( (ret_val = crypto_kem_enc(ct, ss, pk)) != 0) {
            printf("PQCgenKAT ERROR: crypto_kem_enc returned <%d>\n", ret_val);
            return KAT_CRYPTO_FAILURE;
        }
        time_enc = ((double) (clock() - start));
        fprintBstr(fp_rsp, "ct = ", ct, CRYPTO_CIPHERTEXTBYTES);
        fprintBstr(fp_rsp, "ss = ", ss, CRYPTO_BYTES);

        // decoding
//        start = clock();
//        if ( (ret_val = crypto_kem_dec(ss1, ct, sk)) != 0) {
//            printf("PQCgenKAT ERROR: crypto_kem_dec returned <%d>\n", ret_val);
//            return KAT_CRYPTO_FAILURE;
//        }
//        end = clock();
//        time_dec = ((double) (end - start));

        // write time measure to file
        fprintf(fp_rsp, "prepare (μs) = %.0f\n", time_prepare);
//        fprintf(fp_rsp, "crypto_kem_keypair (μs) = %.0f\n", time_keypair);
//        fprintf(fp_rsp, "crypto_kem_enc (μs) = %.0f\n", time_enc);
        fprintf(fp_rsp, "crypto_kem_enc (μs) = %.0f\n", time_enc);
        fprintf(fp_rsp, "\n");

        // no compare possible - dec only
//        if ( memcmp(ss, ss1, CRYPTO_BYTES) ) {
//            printf("PQCgenKAT ERROR: crypto_kem_dec returned bad 'ss' value\n");
//            return KAT_CRYPTO_FAILURE;
//        }

    }

//    fclose(fp_req);
    fclose(fp_rsp);
    fclose(fp_rsp_origin);

    return KAT_SUCCESS;
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
ReadHex(FILE *infile, unsigned char *A, int Length, char *str)
{
    int			i, ch, started;
    unsigned char	ich;

    if ( Length == 0 ) {
        A[0] = 0x00;
        return 1;
    }
    memset(A, 0x00, Length);
    started = 0;
    if ( FindMarker(infile, str) )
        while ( (ch = fgetc(infile)) != EOF ) {
            if ( !isxdigit(ch) ) {
                if ( !started ) {
                    if ( ch == '\n' )
                        break;
                    else
                        continue;
                }
                else
                    break;
            }
            started = 1;
            if ( (ch >= '0') && (ch <= '9') )
                ich = ch - '0';
            else if ( (ch >= 'A') && (ch <= 'F') )
                ich = ch - 'A' + 10;
            else if ( (ch >= 'a') && (ch <= 'f') )
                ich = ch - 'a' + 10;
            else // shouldn't ever get here
                ich = 0;

            for ( i=0; i<Length-1; i++ )
                A[i] = (A[i] << 4) | (A[i+1] >> 4);
            A[Length-1] = (A[Length-1] << 4) | ich;
        }
    else
        return 0;

    return 1;
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

