//
// Created by Tomas on 15.09.2024.
//

#include "randombytes_tomas.h"
#include "shake_prng.h"
#include <stdlib.h>

void randombytes_init(unsigned char *entropy_input, unsigned char *personalization_string, int security_strength) {
    shake_prng_init(entropy_input, NULL, 48, 0);
}

int randombytes(unsigned char *seed, unsigned long long xlen) {
    shake_prng(seed, xlen);
    return 0;
}