 
#include <openssl/sha.h>   
#include <openssl/crypto.h>   
#include <stdio.h>
#include <openssl/bio.h>
#include <openssl/evp.h>
#include <openssl/aes.h>
#include <assert.h>
#include <string.h>


// output[0..19] <- SHA1(input[0..n-1])
void mySHA1(unsigned char * output, unsigned char * input, int n)
{  
    SHA_CTX c;  
   
    SHA1_Init(&c);  
    SHA1_Update(&c, input, n);  
    SHA1_Final(output, &c);  
    OPENSSL_cleanse(&c, sizeof(c));  
}

// output[...] := SHA1(input[..]||0) || SHA1(input[..]||1) || ....
// This function is to compute SHA1 value (of arbitrary desired length) based on the given input. 
void SHA1_hash(
		unsigned char * output,
		unsigned int output_length,
		unsigned char * input,
		unsigned char input_length)
{
	unsigned char local_table[20];

	unsigned int index = 0, i = 0;
	unsigned char nonce = 0;
	while(index < output_length)
	{
		input[input_length] = nonce++;
		mySHA1(local_table, input, input_length+1);

		for(i=0; i<20 && index<output_length; i++, index++)
			output[index] = local_table[i];
	}
}

// input_string is the concatenation of ptr1 and ptr2. 
// i.e., input = ptr1 || ptr2.
// This function is to compute SHA1 value (of arbitrary desired length) based on the given input. 
void SHA1_hash2(
		unsigned char * output,
		const unsigned int output_length,
		const unsigned char * ptr1,
		const unsigned int input_length1,
		const unsigned char * ptr2,
		const unsigned int input_length2)
{
	unsigned char sha1_input[input_length1 + input_length2 + 1]; // extra one byte
	
	memcpy(sha1_input, ptr1, input_length1);
	memcpy(sha1_input+input_length1, ptr2, input_length2);
	SHA1_hash(
		output, 
		output_length, 
		sha1_input,
		input_length1 + input_length2);
}

// It conducts the AES_ECB encryption/decryption for the given input string (16 bytes)
// when enc==AES_ENCRYPT, encryption;
// else decryption;
// Note: here, the input string is of 16 bytes by default. 
void AES_ecb_encrypt(
		const unsigned char * in, 
		unsigned char * out,
		const AES_KEY * key, 
		const int enc)
{
	assert(in && out && key);
	assert((AES_ENCRYPT == enc) || (AES_DECRYPT == enc));

	if (AES_ENCRYPT == enc)
		AES_encrypt(in, out, key);
	else
		AES_decrypt(in, out, key);
}

// It conducts the AES_ECB encryption for the given input string (of arbitrary length). 
int My_AES_ecb_encrypt( 
		unsigned char *out,
		unsigned char *in, 
		int inlen, 
		const unsigned char *key)
{
	AES_KEY aes; 
	if(AES_set_encrypt_key(key,256,&aes)<0) 
		return 0;

	int i;

	if(inlen%16 == 0)
		for(i = 0; i<(inlen/16); i++) 
			AES_ecb_encrypt(in+i*16, out+i*16, &aes,AES_ENCRYPT); 
	else
	{
		unsigned char inbuff[inlen+16];
		unsigned char outbuff[inlen+16];
		
		memcpy(inbuff, in, inlen);
		for(i=0; i<16; i++)
			inbuff[inlen+i] = 0;

		for(i=0; i<=(inlen/16); i++) 
			AES_ecb_encrypt(inbuff+i*16, outbuff+i*16, &aes,AES_ENCRYPT); 
		memcpy(out, outbuff, (inlen/16)*16+16);
	}
	
	return 1;
}


// It conducts the AES_ECB decryption for the given input string (of arbitrary length). 
int My_AES_ecb_decrypt(
		unsigned char * out,
		unsigned char * in, int inlen,
		const unsigned char * key)
{
	AES_KEY aes; 
	if(AES_set_decrypt_key(key,256,&aes)<0) 
		return 0;
		
	int i;
	
	if(inlen%16 == 0)
		for(i=0; i<(inlen/16); i++) 
			AES_ecb_encrypt(in+i*16,out+i*16, &aes, AES_DECRYPT); 
	else
	{
		unsigned char outbuff[inlen+16];
		
		for(i=0; i<=(inlen/16); i++) 
			AES_ecb_encrypt(in+i*16,outbuff+i*16, &aes, AES_DECRYPT); 

		memcpy(out, outbuff, inlen);
	}

	return 1;
}

