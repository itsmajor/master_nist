#include "api.h"
#include <string.h>
#include "sign_keypairPKI.h"
#include "signPKI.h"
#include "sign_openPKI.h"


int crypto_sign_keypair(unsigned char *pk,unsigned char *sk)
{
    return sign_keypairPKI((UINT*)pk,(UINT*)sk);
}

int crypto_sign(
  unsigned char *sm,unsigned long long *smlen,
  const unsigned char *m,unsigned long long mlen,
  const unsigned char *sk)
{
    *smlen=mlen+SIZE_PKI_SIGNATURE_BYTES;
    memmove(sm+SIZE_PKI_SIGNATURE_BYTES,m,(size_t)mlen);
    return signPKI((UINT*)sm,m,(size_t)mlen,(UINT*)sk);
}

int crypto_sign_open(
  unsigned char *m,unsigned long long *mlen,
  const unsigned char *sm,unsigned long long smlen,
  const unsigned char *pk)
{
    *mlen=smlen-SIZE_PKI_SIGNATURE_BYTES;
    memmove(m,sm+SIZE_PKI_SIGNATURE_BYTES,(size_t)(*mlen));
    return sign_openPKI(sm+SIZE_PKI_SIGNATURE_BYTES,(size_t)(*mlen),(UINT*)sm,\
                        (UINT*)pk);
}
