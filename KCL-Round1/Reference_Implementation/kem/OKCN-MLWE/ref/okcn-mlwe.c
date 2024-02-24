

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

#include "api.h"
#include "polynomial.h"
#include "vector.h"
#include "io.h"
#include "reduce.h"
#include "rng.h"

int Instance();

int main( )
{	    
	int counter_of_failure = 0;
	int number_of_loops = 10000;
	int i;

	printf("Now we are testing Instance() %d times. \n\n", number_of_loops);

	clock_t start,end; 
	start = clock(); 

	unsigned char  entropy_input[48];
	for(i=0; i<48; i++)
		entropy_input[i] = i;

	randombytes_init(entropy_input, NULL, 256);


	for(i=1; i<=number_of_loops; i++)
	{
		if(i%(number_of_loops/10)==0)
			printf("i = %d,\t failure = %d\n", i, counter_of_failure);
		counter_of_failure += Instance();
	}
	end = clock(); 

	printf("\nIn sum, counter_of_failure = %d.\n\n", counter_of_failure);
	printf("Running time = %f seconds.\n\n",(double)(end-start)/CLK_TCK);

	return 0;
}

int Instance()
{
	int i;

	unsigned char pk[PUBLICKEY_BYTES];
	unsigned char sk[SECRETKEY_BYTES];
	unsigned char ct[CIPHERTEXT_BYTES];

	unsigned int Key1[MLWE_N], Key2[MLWE_N];
	unsigned char Key1_string[MLWE_N/8];
	unsigned char Key2_string[MLWE_N/8];

	crypto_kem_keypair(pk, sk);
	crypto_kem_enc(ct, Key2_string, pk);
	crypto_kem_dec(Key1_string, ct, sk);

	unpack_key(Key1, Key1_string);
	unpack_key(Key2, Key2_string);

	// comparison
	int counter = 0;
	for(i=0; i<MLWE_N; i++)
		if(Key1[i] != Key2[i])
			counter++;

	// if Key1=Key2, return 0; else return 1;
	return (counter!=0);
}


