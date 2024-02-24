/*
We modifiy NIST provided file PQCgenKAT_encrypt.c to generate our KAT input output tuples files for 3 aspects (keypair generation, encryption
and decryption) of our encrypt schemes.
*/
 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "rng.h"
#include "api.h"
#include "parameter.h"
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
   // char                fn_req[32], fn_rsp[32];
   // FILE                *fp_req, *fp_rsp;

    char                fn_keypair[32], fn_enc[32], fn_dec[32];
    FILE                *fp_keypair, *fp_enc, *fp_dec;
    unsigned char       seed[75][48];
    unsigned char       msg[75][100];
    unsigned char       entropy_input[48];
    unsigned char         *c, *m1;
    unsigned long long  mlen[75], clen, mlen1;
    int                 count;
    int                 done;
    unsigned char       pk[CRYPTO_PUBLICKEYBYTES], sk[CRYPTO_SECRETKEYBYTES];
    int                 ret_val;
    
    // Create the REQUEST file
    sprintf(fn_keypair, "genKAT_encrypt_keypair.txt");
    if ( (fp_keypair = fopen(fn_keypair, "w")) == NULL ) {
        printf("Couldn't open <%s> for write\n", fn_keypair);
        return KAT_FILE_OPEN_ERROR;
    }
    sprintf(fn_enc, "genKAT_encrypt_enc.txt");
    if ( (fp_enc = fopen(fn_enc, "w")) == NULL ) {
        printf("Couldn't open <%s> for write\n", fn_enc);
        return KAT_FILE_OPEN_ERROR;
    }

    sprintf(fn_dec, "genKAT_encrypt_dec.txt");
    if ( (fp_dec = fopen(fn_dec, "w")) == NULL ) {
        printf("Couldn't open <%s> for write\n", fn_dec);
        return KAT_FILE_OPEN_ERROR;
    }


// print header information

fprintf(fp_keypair, "#Algorithm name: %s\n#Test name: crypto_encrypt_keypair input and output tuples \n\n", CRYPTO_ALGNAME); 
fprintf(fp_keypair, "#This file includes 75 input and output tuples for function crypto_encrypt_keypair in encrypt.c file. \n  We believe they are informative for debugging and understanding our implementation. \n\n" );
fprintf(fp_keypair, "#Function: void crypto_encrypt_keypair_KAT( unsigned char * pk,  unsigned char * sk,  const unsigned char * keypair_seed)  \n\n" );

 

fprintf(fp_enc, "#Algorithm name: %s\n#Test name: crypto_encrypt_enc_KAT input and output tuples \n\n", CRYPTO_ALGNAME); 
fprintf(fp_enc, "#This file includes 75 input and output tuples for function crypto_encrypt_KAT in encrypt.c file. \n  We believe they are informative for debugging and understanding our implementation. \n\n" );
fprintf(fp_enc, "#Function:void crypto_encrypt_KAT( unsigned char * c,  unsigned long long * clen, const unsigned char * m,  unsigned long long mlen, const unsigned char * pk, const unsigned char * enc_seed)  \n\n" );
 


fprintf(fp_dec, "#Algorithm name: %s\n#Test name: crypto_encrypt_open input and output tuples \n\n", CRYPTO_ALGNAME); 
fprintf(fp_dec, "#This file includes 75 input and output tuples for function crypto_encrypt_open in encrypt.c file. \n  We believe they are informative for debugging and understanding our implementation. \n\n" );
fprintf(fp_dec, "#Function: int crypto_encrypt_open( unsigned char * m,  unsigned long long * mlen, const unsigned char * c,  unsigned long long clen, const unsigned char * sk); \n\n" );
 
 

int i,j;


    
    for (  i=0; i<48; i++)
        entropy_input[i] = i;

    randombytes_init(entropy_input, NULL, 256);
    for ( i=0; i<3; i++) {
        for (  j=0; j<25; j++) {
            
            randombytes(seed[i*25+j], 48);
           
            mlen[i*25+j] = 16+i*8;
            
            randombytes(msg[i*25+j], mlen[i*25+j]);
             
        }
    }

// for ( i=0; i<15; i++) {  printf("%d  \n",  mlen[i]);   }



   // fclose(fp_req);
    
   // generate 100 KAT data in three files



 
    for ( i=0; i<75; i++) {
      
        randombytes_init(seed[i], NULL, 256);
 
        //fprintf(fp_rsp, "mlen = %llu\n", mlen);
        
       // m = (unsigned char *)calloc(mlen[i], sizeof(unsigned char));
        m1 = (unsigned char *)calloc(mlen[i]+CRYPTO_BYTES, sizeof(unsigned char));
        c = (unsigned char *)calloc(mlen[i]+CRYPTO_BYTES, sizeof(unsigned char));
 

////11//////////////////////////////////////////////////////////////////////////////////       
        
        // Generate the public/private keypair
 
     unsigned char keypair_seed[KEYPAIR_SEED_BYTES];
    randombytes(keypair_seed, KEYPAIR_SEED_BYTES);

    crypto_encrypt_keypair_KAT(pk, sk, keypair_seed);

        //print KAT result:

fprintf(fp_keypair, "***Input and output tuples number %d ************************* \n\n", i+1 );
fprintf(fp_keypair, "When the input value seed is as following:  \n"  );
fprintBstr(fp_keypair, "seed = ", keypair_seed, KEYPAIR_SEED_BYTES);

fprintf(fp_keypair, "\nThe output of crypto_encrypt_keypair_KAT ( pk and sk ) will be as following: \n"  );
        fprintBstr(fp_keypair, "pk = ", pk, CRYPTO_PUBLICKEYBYTES);
        fprintBstr(fp_keypair, "sk = ", sk, CRYPTO_SECRETKEYBYTES);
        fprintf(fp_keypair, "\n\n");





//////////////////////////////////////////////////////////////////////////////////////       
        
        //  Generate the crypto_encrypt_KAT tuples
 
	unsigned char enc_seed[ENC_SEED_BYTES];
	randombytes(enc_seed, ENC_SEED_BYTES);



        crypto_encrypt_KAT (c, &clen, msg[i], mlen[i], pk, enc_seed);


        //print KAT result:

fprintf(fp_enc, "***Input and output tuples number %d ************************* \n\n", i+1 );
fprintf(fp_enc, "When inputs ( message, mlen,  seed and pk) are as following: \n"  );

fprintf(fp_enc, "mlen = %llu\n", mlen);
fprintBstr(fp_enc, "message = ", msg[i], mlen[i]);
fprintBstr(fp_enc, "seed = ", enc_seed, ENC_SEED_BYTES);
fprintBstr(fp_enc, "pk = ", pk, CRYPTO_PUBLICKEYBYTES);
fprintf(fp_enc, "\nThe output of crypto_encrypt_KAT ( clen  and ciphertext ) will be as following: \n"  );

       fprintf(fp_enc, "clen = %llu\n", clen);
       fprintBstr(fp_enc, "ciphertext = ", c, clen);

        
        fprintf(fp_enc, "\n");


 

//////////////////////////////////////////////////////////////////////////////////////       
        
        //  Generate the crypto_encrypt_open_KAT tuples
        
        if ( ( ret_val = crypto_encrypt_open(m1, &mlen1, c, clen, sk)) != 0) {
            printf("crypto_encrypt_open returned <%d>\n", ret_val);
            return KAT_CRYPTO_FAILURE;
        }




fprintf(fp_dec, "***Input and output tuples number %d ************************* \n\n", i+1 );
fprintf(fp_dec, "when input of crypto_encrypt_open(cipher text, clen and sk) are as following:  \n"  );
       fprintf(fp_dec, "clen = %llu\n", clen);
       fprintBstr(fp_dec, "ciphertext = ", c, clen);
       fprintBstr(fp_dec, "sk = ", sk, CRYPTO_SECRETKEYBYTES);
fprintf(fp_dec, "\nThe output(mlen1 and message1) will be as following: \n"  );

 
    fprintf(fp_dec, "mlen1 = %llu\n", mlen1);
fprintBstr(fp_dec, "m1 = ", m1, mlen1);
 
      
        
        fprintf(fp_dec, "\n");





        
        
        if ( mlen[i] != mlen1 ) {
            printf("crypto_encrypt_open returned bad 'mlen': Got <%llu>, expected <%llu>\n", mlen1, mlen[i]);
            return KAT_CRYPTO_FAILURE;
        }


        
        if ( memcmp( msg[i], m1, mlen[i]) ) {
            printf("crypto_encrypt_open returned bad 'm' value\n");
            return KAT_CRYPTO_FAILURE;
        }
        
 
        
        free(m1);
        free(c);

    }
    

 


   fclose(fp_keypair);
    fclose(fp_enc);
    fclose(fp_dec);

    return KAT_SUCCESS;
}

 
  
// we use fprintBstr function in NIST provided file PQCgenKAT_encrypt.c here
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

