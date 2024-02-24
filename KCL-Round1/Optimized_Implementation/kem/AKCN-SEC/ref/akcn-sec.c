

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

#include "api.h"
#include "polynomial.h"
#include "io.h"
#include "reduce.h"
#include "sec.h"
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

	unsigned char entropy_input[48];
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
	unsigned char pk[PUBLICKEY_BYTES];
	unsigned char sk[SECRETKEY_BYTES];
	unsigned char ct[CIPHERTEXT_BYTES];
	
	unsigned char ss1[KEY_BYTES], ss2[KEY_BYTES];
	unsigned int Key1[SEC_SIGNIFICANT_BITS+SEC_PADDING_OF_SIGNIFICANT_BITS];
	unsigned int Key2[SEC_SIGNIFICANT_BITS+SEC_PADDING_OF_SIGNIFICANT_BITS];

	
	crypto_kem_keypair(pk, sk);
	crypto_kem_enc(ct, ss2, pk); 
	crypto_kem_dec(ss1, ct, sk);

	unpack_key(Key1, ss1);	// unpack Key1
	unpack_key(Key2, ss2);	// unpack Key2

		// compare Key1 vs. Key2. 
	unsigned int counter = 0;
	for(unsigned int i=0; i<SEC_SIGNIFICANT_BITS+SEC_PADDING_OF_SIGNIFICANT_BITS; i++)
		if(Key1[i] != Key2[i])
			counter++;

	// if Key1==Key2 then return 0; else return 0;
	return (counter!=0);
}






