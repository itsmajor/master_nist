// AKCN_MLWE.c
  
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

	printf("Now we are testing Instance() %d times. \n\n", number_of_loops);

	clock_t start,end; 
	start = clock(); 
	for(int i=1; i<=number_of_loops; i++)
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

// return 0 if everything works fine; otherwise, return 1;
int Instance()
{
	unsigned char pk[PUBLICKEY_BYTES];
	unsigned char sk[SECRETKEY_BYTES];
	
	unsigned char ciphertext[CIPHERTEXT_BYTES];
	unsigned long long clen;
	
	unsigned char plaintext[MAX_MESSAGE_LENGTH];
	unsigned long long mlen;
	
	unsigned char recovered_plaintext[MAX_MESSAGE_LENGTH+16];
	unsigned long long recovered_plaintext_length; 
	
	{{ // prepare the random plaintext 
		time_t t; 
		srand((unsigned) time(&t)); 
		
		mlen = rand()%(MAX_MESSAGE_LENGTH-1)+1;
		for(unsigned int i=0; i<mlen; i++)
			plaintext[i] = rand() % 256;
	}}

	crypto_encrypt_keypair(
			pk, 
			sk);
		
	crypto_encrypt(
			ciphertext, &clen, 
			plaintext, mlen, 
			pk);

	crypto_encrypt_open(
			recovered_plaintext,  &recovered_plaintext_length,
			ciphertext, clen,
			sk);

	// equivalence test
	if(recovered_plaintext_length != mlen)
		return 1;	//indicating failure
	
	for(unsigned int i=0; i<mlen; i++)
		if(recovered_plaintext[i] != plaintext[i])
			return 1;	//indicating failure

	return 0;	// indicating success
}




