#include "rng-state-c.h"

#include <R_ext/Random.h>

#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>

static RngStateInt32s grsi;

double* user_unif_rand()
{
  // printf("user_unif_rand\n");
  static double urand = 0.0;
  urand = rng_runif(&grsi);
  return &urand;
}

void user_unif_init(Int32 seed_in)
{
  seed_in = 3602842457U * (seed_in - 2358491998U);
  // printf("user_unif_init %d\n", seed_in);
  rng_reset(&grsi);
  rng_split(&grsi, &grsi, seed_in);
}

int* user_unif_nseed()
{
  // printf("user_unif_nseed\n");
  static int nseed = RNG_NUM_OF_INT32;
  return &nseed;
}

int32_t* user_unif_seedloc()
{
  // printf("user_unif_seedloc\n");
  return (int32_t*)grsi.v;
}

double* user_norm_rand()
{
  // printf("user_norm_rand\n");
  static double grand = 0.0;
  grand = rng_rnorm(&grsi);
  return &grand;
}
