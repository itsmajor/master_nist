#include "api.h"
#include <stdlib.h>
#include <stdio.h>  

 #define count 50000  //times we run for each function

 

// it returns current cpu cpucycles.   

long long cpucycles(void)      
{   
  unsigned long long result;                               
  asm volatile(".byte 15;.byte 49;shlq $32,%%rdx;orq %%rdx,%%rax"
    : "=a" (result) ::  "%rdx");               
  return result;    
}

 // input t: if count = 50000 then t record 50000 cpucycles point. 
// it first compute how many cpucycles it will take for each time we  execute a function.
// then it print out the average value.
static void print_results(const char *s, unsigned long long *t, size_t tlen)
{
  size_t i;
  printf("%s", s);
  for(i=0;i<tlen-1;i++)
  {
    t[i] = t[i+1] - t[i];
  
  }

  unsigned long long result =0;

   
  for(i=0;i<tlen-1;i++)
    result += t[i];

   result = result/(tlen);


  printf("\n");
  printf("average cpucycles are: %llu\n", result);
  printf("\n");
}

 


unsigned long long t[count];


void main()
{
  unsigned char sk_a[CRYPTO_SECRETKEYBYTES];
  unsigned char pk_a[CRYPTO_PUBLICKEYBYTES];
 
 
  unsigned long long  mlen =20000;                  //length of message
  unsigned long long  clen = mlen+CRYPTO_BYTES;       //length of cipher text


// we locate enough space such that each time the inputs for function are different.
  unsigned char* send_public_key = (unsigned char*) malloc(count*CRYPTO_PUBLICKEYBYTES);
  unsigned char* send_cipher = (unsigned char*) malloc(count*clen);
  unsigned char* message = (unsigned char*) malloc(mlen);

 
  int i;

   
  for(i=0; i<count; i++)
  {
    t[i] = cpucycles();
    crypto_encrypt_keypair(send_public_key+i*CRYPTO_PUBLICKEYBYTES, sk_a);
 
  }
  print_results("For function crypto_encrypt_keypair: ", t, count);

  for(i=0; i<count; i++)
  {
    t[i] = cpucycles();
    crypto_encrypt( send_cipher+i*clen, &clen, message , mlen, send_public_key+i*CRYPTO_PUBLICKEYBYTES);

 
  }
  print_results("For function crypto_encrypt:  ", t, count);

  for(i=0; i<count; i++)
  {
    t[i] = cpucycles();
    crypto_encrypt_open(message, &mlen,  send_cipher+i*clen, clen,  sk_a);
 
  }
  print_results("For function crypto_encrypt_open:  ", t, count);
 
  
 
 
 // free memery 
  free(send_public_key);
  free(send_cipher);
  free(message);
 
}
































