#ifndef _SIGN_OPENPKI_H
#define _SIGN_OPENPKI_H

#include "config_PKI.h"
#include <stddef.h>


int sign_openPKI(const unsigned char* m, size_t len, const UINT* sm, 
                 const UINT* pk);


#endif
