#include "rng-state-c.h"

#include <R.h>
#include <Rinternals.h>

#include <stdio.h>
#include <assert.h>

SEXP split_rng_state(SEXP rng, SEXP si)
{
  // printf("split_rng_state %d\n", length(rng));
  assert(RNG_NUM_OF_INT32 + 1 == length(rng));
  int n = length(si);
  if (n == 0) {
    return rng;
  } else {
    uint32_t type;
    RngStateInt32s rsi;
    uint32_t* p_rng;
    p_rng = INTEGER(rng);
    type = p_rng[0];
    for (int i = 0; i < RNG_NUM_OF_INT32; ++i) {
      rsi.v[i] = p_rng[i + 1];
    }
    switch (TYPEOF(si)) {
      case INTSXP:
        for (int i = 0; i < n; ++i) {
          long sindex = INTEGER(si)[i];
          rng_split(&rsi, &rsi, sindex);
        }
        break;
      case REALSXP:
        for (int i = 0; i < n; ++i) {
          long sindex = REAL(si)[i];
          rng_split(&rsi, &rsi, sindex);
        }
        break;
      default:
        assert(0);
    }
    SEXP result = PROTECT(allocVector(INTSXP, RNG_NUM_OF_INT32 + 1));
    p_rng = INTEGER(result);
    p_rng[0] = type;
    for (int i = 0; i < RNG_NUM_OF_INT32; ++i) {
      p_rng[i + 1] = rsi.v[i];
    }
    UNPROTECT(1);
    return result;
  }
}

