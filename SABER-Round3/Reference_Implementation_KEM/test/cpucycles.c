#include "cpucycles.h"

long long cpucycles(void)
{
  unsigned long long result;
  asm volatile("isb; mrs %0, CNTVCT_EL0" : "=r"(result));
  return result;
}
