//
// Created by Major on 22.10.2024.
// used by Picnic only - redirect rand_bytes to PRNG (rng.h)

#ifndef RANDOMNESS_H
#define RANDOMNESS_H

#include <stddef.h>
#include <stdint.h>
#include <rng.h>

int rand_bytes(uint8_t* dst, size_t len);
int rand_bits(uint8_t* dst, size_t num_bits);

#endif
