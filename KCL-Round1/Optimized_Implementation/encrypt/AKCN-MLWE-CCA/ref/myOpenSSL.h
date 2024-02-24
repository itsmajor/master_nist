#ifndef MYOPENSSL_H 
#define MYOPENSSL_H

#include <openssl/aes.h>
void mySHA1(unsigned char * output, unsigned char * input, int input_length);
void SHA1_hash(
		unsigned char * output,
		unsigned int output_length,
		unsigned char * input,
		unsigned char input_length);
void SHA1_hash2(
		unsigned char * output,
		const unsigned int output_length,
		const unsigned char * ptr1,
		const unsigned int input_length1,
		const unsigned char * ptr2,
		const unsigned int input_length2);
		
void AES_ecb_encrypt(
		const unsigned char * in, 
		unsigned char * out,
		const AES_KEY * key, 
		const int enc);
int My_AES_ecb_encrypt( 
		unsigned char *out,
		unsigned char *in, 
		int inlen, 
		const unsigned char *key);
int My_AES_ecb_decrypt(
		unsigned char * out,
		unsigned char * in, int inlen,
		const unsigned char * key);
		
#endif
 
