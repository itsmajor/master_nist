#include "api.h"
#include <stdlib.h>
#include <stdio.h>  

 #define count 50000  //times we run for each function

 
  
// it returns current cpu cpucycles.  
long long cpucycles(void)      
{   
  unsigned long long result;                               
  asm volatile("isb; mrs %0, CNTVCT_EL0" : "=r"(result));
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
 
 

  unsigned char key_a[32], key_b[32];

  // we locate enough space such that each time the inputs for function are different.
  unsigned char* senda = (unsigned char*) malloc(count*CRYPTO_PUBLICKEYBYTES);
  unsigned char* sendb = (unsigned char*) malloc(count*CRYPTO_CIPHERTEXTBYTES);

 
 
  int i;

   
  for(i=0; i<count; i++)
  {
    t[i] = cpucycles();
    crypto_kem_keypair(senda+i*CRYPTO_PUBLICKEYBYTES, sk_a);
  }
  print_results("For function crypto_kem_keypair: ", t, count);

  for(i=0; i<count; i++)
  {
    t[i] = cpucycles();
    crypto_kem_enc( sendb+i*CRYPTO_CIPHERTEXTBYTES, key_b, senda+i*CRYPTO_PUBLICKEYBYTES);
  }
  print_results("For function crypto_kem_enc:  ", t, count);

  for(i=0; i<count; i++)
  {
    t[i] = cpucycles();
    crypto_kem_dec(key_a, sendb+i*CRYPTO_CIPHERTEXTBYTES, sk_a);
  }
  print_results("For function crypto_kem_dec:  ", t, count);
 
  
 
 
 // free memery
  free(senda);

 
  free(sendb);
 
 
}
































