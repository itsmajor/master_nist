#ifndef _SIGNPKI_HPP
#define _SIGNPKI_HPP

#include "config_PKI.h"
#include <stddef.h>


int signPKI(UINT* sm, const unsigned char* m, size_t len, const UINT* sk);



#endif
