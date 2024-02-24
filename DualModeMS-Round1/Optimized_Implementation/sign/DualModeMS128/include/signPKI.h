#ifndef _SIGNPKI_H
#define _SIGNPKI_H

#include "config_PKI.h"
#include <stddef.h>


int signPKI(UINT* sm, const unsigned char* m, size_t len, const UINT* sk);



#endif
