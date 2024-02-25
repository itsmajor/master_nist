#ifndef _HORNEREVALUATEGF2_X_HPP
#define _HORNEREVALUATEGF2_X_HPP

#include "config_PKI.h"

#include <NTL/GF2EX.h>

using namespace NTL;


void castMACToNTL(GF2EX& F_NTL, const UINT* F);
void castMACToVecmNTL(Vec<GF2EX>& F_NTL, const UINT* F);
void castMACToVecalphaNTL(Vec<GF2EX>& F_NTL, const UINT* F);

UINTk hornerEvaluateGF2k_X(const GF2EX& F_NTL, UINTk X);
void hornerEvaluateGF2k_X_multipoly(UINT* vec_p, const Vec<GF2EX>& F_NTL, UINTk X);

#endif
