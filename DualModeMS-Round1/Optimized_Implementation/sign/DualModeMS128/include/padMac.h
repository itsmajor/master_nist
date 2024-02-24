#ifndef _PADMAC_H
#define _PADMAC_H

#include "config_PKI.h"

/* If K_REM==0, mq == pad_mq and this function becomes useless */
#if K_REM
    void padMac(UINT* pad_mq, const UINT* mq);
#endif

#endif
