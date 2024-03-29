/* ****************************** *
 * Titanium_CPA_super             *
 * Implemented by Raymond K. ZHAO *
 *                                *
 * NTT functions                  *
 * ****************************** */
 
#ifndef NTT_H
#define NTT_H

#include <stdint.h>

void intt_3328_3328(uint32_t *a);
void intt_1280_1280(uint32_t *a);
void ntt_3072_3072(uint32_t *a);
void intt_3072_3072_inv(uint32_t *a);
void ntt_1280_1280_inv(uint32_t *a);

#endif
