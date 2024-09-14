//
// Created by Tomas on 15.09.2024.
//

#ifndef MASTER_NIST_RANDOMBYTES_TOMAS_H
#define MASTER_NIST_RANDOMBYTES_TOMAS_H

void randombytes_init(unsigned char *entropy_input, unsigned char *personalization_string, int security_strength);
int randombytes(unsigned char *x, unsigned long long xlen);


#endif
