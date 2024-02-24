#ifndef _MERKLETREE_H
#define _MERKLETREE_H

#include "config_PKI.h"


void merkleTreeMerge(unsigned char* roots, unsigned char* tree);
void merkleTreeOpenPath(UINT* path, const UINT* tree, unsigned int index);
int merkleTreeVerify(const UINT* roots, UINT* hash_point , const UINT* path, \
unsigned int index);


#endif
