#ifndef _HORNEREVALUATEGF2_X_H
#define _HORNEREVALUATEGF2_X_H

#include "config_PKI.h"


UINTk hornerEvaluateGF2k_X(const UINT* P, UINTk X);
void hornerEvaluateGF2k_X_multipoly(UINT* vec_p, const UINT* P, UINTk X);


#endif
