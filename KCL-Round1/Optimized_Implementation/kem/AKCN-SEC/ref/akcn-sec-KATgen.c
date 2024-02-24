
/*
We modifiy NIST provided file PQCgenKAT_kem.c to generate our KAT input output tuples files for 3 aspects (keypair generation, encapsulation
and decapsulation) of our kem schemes.
*/

 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "rng.h"   
#include "api.h"         

#define	MAX_MARKER_LEN		50
#define KAT_SUCCESS          0
#define KAT_FILE_OPEN_ERROR -1
#define KAT_DATA_ERROR      -3
#define KAT_CRYPTO_FAILURE  -4

int		FindMarker(FILE *infile, const char *marker);
int		ReadHex(FILE *infile, unsigned char *A, int Length, char *str);
void	fprintBstr(FILE *fp, char *S, unsigned char *A, unsigned long long L);

int
main()
{
    char                fn_keypair[32], fn_enc[32], fn_dec[32];
    FILE                *fp_keypair, *fp_enc, *fp_dec;
    unsigned char       seed[100][48];
    unsigned char       entropy_input[48];
    unsigned char       ct[CRYPTO_CIPHERTEXTBYTES], ss[CRYPTO_BYTES], ss1[CRYPTO_BYTES];
    int                 count;
    int                 done;
    unsigned char       pk[CRYPTO_PUBLICKEYBYTES], sk[CRYPTO_SECRETKEYBYTES];
    int                 ret_val;
    
    // Create the REQUEST file
    sprintf(fn_keypair, "genKAT_kem_keypair.txt");
    if ( (fp_keypair = fopen(fn_keypair, "w")) == NULL ) {
        printf("Couldn't open <%s> for write\n", fn_keypair);
        return KAT_FILE_OPEN_ERROR;
    }
    sprintf(fn_enc, "genKAT_kem_enc.txt");
    if ( (fp_enc = fopen(fn_enc, "w")) == NULL ) {
        printf("Couldn't open <%s> for write\n", fn_enc);
        return KAT_FILE_OPEN_ERROR;
    }

    sprintf(fn_dec, "genKAT_kem_dec.txt");
    if ( (fp_dec = fopen(fn_dec, "w")) == NULL ) {
        printf("Couldn't open <%s> for write\n", fn_dec);
        return KAT_FILE_OPEN_ERROR;
    }

// print header information

fprintf(fp_keypair, "#Algorithm name: %s\n#Test name: crypto_kem_keypair_KAT input and output tuples \n\n", CRYPTO_ALGNAME); 
fprintf(fp_keypair, "#This file includes 100 input and output tuples for function crypto_kem_keypair_KAT in kem.c file. \n  We believe they are informative for debugging and understanding our implementation. \n\n" );
fprintf(fp_keypair, "#Function: void crypto_kem_keypair_KAT( unsigned char * pk,   unsigned char * sk,  const unsigned char * seed);  \n\n" );

 

fprintf(fp_enc, "#Algorithm name: %s\n#Test name: crypto_kem_enc_KAT input and output tuples \n\n", CRYPTO_ALGNAME); 
fprintf(fp_enc, "#This file includes 100 input and output tuples for function crypto_kem_enc_KAT in kem.c file. \n  We believe they are informative for debugging and understanding our implementation. \n\n" );
fprintf(fp_enc, "#Function: void crypto_kem_enc_KAT( unsigned char * ct, unsigned char * ss,  const unsigned char * pk, const unsigned char * noise_seed);  \n\n" );
 


fprintf(fp_dec, "#Algorithm name: %s\n#Test name: crypto_kem_dec input and output tuples \n\n", CRYPTO_ALGNAME); 
fprintf(fp_dec, "#This file includes 100 input and output tuples for function crypto_kem_dec in kem.c file. \n  We believe they are informative for debugging and understanding our implementation. \n\n" );
fprintf(fp_dec, "#Function: void int crypto_kem_dec( unsigned char * ss,  const unsigned char * ct, const unsigned char * sk);  \n\n" );
 
 

    
// generate 100 initial seed
    for (int i=0; i<48; i++)
        entropy_input[i] = i;
    randombytes_init(entropy_input, NULL, 256);
    for (int i=0; i<100; i++) 
    {
    	randombytes(seed[i], 48);
    }

// generate 100 KAT data in three files
    for (int i=0; i<100; i++) {
 
        randombytes_init(seed[i], NULL, 256);





//////////////////////////////////////////////////////////////////////////////////////       
        
        // Generate the public/private keypair

	unsigned char seed[UNIFORM_POLY_SEED_BYTES+SMALL_POLY_SEED_BYTES];
	randombytes(seed, UNIFORM_POLY_SEED_BYTES+SMALL_POLY_SEED_BYTES);

        crypto_kem_keypair_KAT(pk, sk, seed);

        //print KAT result:

fprintf(fp_keypair, "***Input and output tuples number %d ************************* \n\n", i+1 );
fprintf(fp_keypair, "When the input value seed is as following:  \n"  );
fprintBstr(fp_keypair, "seed = ", seed, UNIFORM_POLY_SEED_BYTES+SMALL_POLY_SEED_BYTES);

fprintf(fp_keypair, "\nThe output of crypto_kem_keypair_KAT ( pk and sk ) will be as following: \n"  );
        fprintBstr(fp_keypair, "pk = ", pk, CRYPTO_PUBLICKEYBYTES);
        fprintBstr(fp_keypair, "sk = ", sk, CRYPTO_SECRETKEYBYTES);
        fprintf(fp_keypair, "\n\n");


//////////////////////////////////////////////////////////////////////////////////

        // Generate the crypto_kem_enc_KAT tuples
	unsigned char small_poly_seed[SMALL_POLY_SEED_BYTES];
	randombytes(small_poly_seed, SMALL_POLY_SEED_BYTES);

        crypto_kem_enc_KAT(ct, ss, pk, small_poly_seed);

 
        //print KAT result:

fprintf(fp_enc, "***Input and output tuples number %d ************************* \n\n", i+1 );
fprintf(fp_enc, "When input seed and pk are as following: \n"  );
fprintBstr(fp_enc, "seed = ", small_poly_seed, SMALL_POLY_SEED_BYTES);
fprintBstr(fp_enc, "pk = ", pk, CRYPTO_PUBLICKEYBYTES);
fprintf(fp_enc, "\nThe output of crypto_kem_enc_KAT ( ct and ss ) will be as following: \n"  );

        fprintBstr(fp_enc, "ct = ", ct, CRYPTO_CIPHERTEXTBYTES);
        fprintBstr(fp_enc, "ss = ", ss, CRYPTO_BYTES);
        
        fprintf(fp_enc, "\n");


//////////////////////////////////////////////////////////////////////////////////





         // Generate the crypto_kem_dec tuples
        if ( (ret_val = crypto_kem_dec(ss1, ct, sk)) != 0) {
            printf("crypto_kem_dec returned <%d>\n", ret_val);
            return KAT_CRYPTO_FAILURE;
        }

        //print KAT result:


fprintf(fp_dec, "***Input and output tuples number %d ************************* \n\n", i+1 );
fprintf(fp_dec, "when input of crypto_kem_dec(ct and sk) are as following:  \n"  );
fprintBstr(fp_dec, "ct = ", ct, CRYPTO_CIPHERTEXTBYTES);
fprintBstr(fp_dec, "sk = ", sk, CRYPTO_SECRETKEYBYTES);
fprintf(fp_dec, "\nThe output(ss1) will be as following: \n"  );

 
        fprintBstr(fp_dec, "ss1 = ", ss1, CRYPTO_BYTES);
        
        fprintf(fp_dec, "\n");
 





//////////////////////////////////////////////////////////////////////////////////
        if ( memcmp(ss, ss1, CRYPTO_BYTES) ) {
            printf("crypto_kem_dec returned bad 'ss' value\n");
            return KAT_CRYPTO_FAILURE;
        }


 


    }
    fclose(fp_keypair);
    
 
    
    fclose(fp_enc);
    fclose(fp_dec);

    return KAT_SUCCESS;
}


 
 
// we use fprintBstr function in NIST provided file PQCgenKAT_kem.c here
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

