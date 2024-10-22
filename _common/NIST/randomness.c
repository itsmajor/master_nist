//
// Created by Major on 22.10.2024.
// used by Picnic only - redirect to PRNG (rng.h)


#include <rng.h>
#include "randomness.h"

int rand_bytes(uint8_t *dst, size_t len) {
    randombytes(dst, len);
    return 0;
}

int rand_bits(uint8_t *dst, size_t num_bits) {
    const size_t num_bytes = (num_bits + 7) / 8;
    const size_t num_extra_bits = num_bits % 8;

    rand_bytes(dst, num_bytes);

    if (num_extra_bits) {
        dst[num_bytes - 1] &= UINT8_C(0xff) << (8 - num_extra_bits);
    }

    return 0;
}

