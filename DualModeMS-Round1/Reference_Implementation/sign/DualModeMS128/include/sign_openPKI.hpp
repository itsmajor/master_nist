#ifndef _SIGN_OPENPKI_HPP
#define _SIGN_OPENPKI_HPP

#include "config_PKI.h"
#include <stddef.h>


int sign_openPKI(const unsigned char* m, size_t len, const UINT* sm, 
                 const UINT* pk);


#endif
