#include "rng-state-c.h"

#include <R.h>
#include <Rinternals.h>

#include <stdio.h>
#include <assert.h>

SEXP root_rng_state()
{
  RngStateInt32s rsi;
  rng_reset(&rsi);
  SEXP result = PROTECT(allocVector(INTSXP, RNG_NUM_OF_INT32 + 1));
  uint32_t* p_rng = INTEGER(result);
  p_rng[0] = 305; // type = "user", "user"
  for (int i = 0; i < RNG_NUM_OF_INT32; ++i) {
    p_rng[i + 1] = rsi.v[i];
  }
  UNPROTECT(1);
  return result;
}

SEXP split_rng_state(SEXP rng, SEXP si)
{
  // printf("split_rng_state %d\n", length(rng));
  assert(RNG_NUM_OF_INT32 + 1 == length(rng));
  int n = length(si);
  if (n == 0) {
    return rng;
  } else if (n == 1) {
    long sindex = 0;
    const char* sindex_str = NULL;
    switch (TYPEOF(si)) {
      case INTSXP:
        sindex = INTEGER(si)[0];
        break;
      case REALSXP:
        sindex = REAL(si)[0];
        break;
      case STRSXP:
        sindex_str = CHAR(STRING_ELT(si, 0));
        break;
      default:
        assert(0);
    }
    uint32_t type;
    RngStateInt32s rsi;
    uint32_t* p_rng;
    p_rng = INTEGER(rng);
    type = p_rng[0];
    for (int i = 0; i < RNG_NUM_OF_INT32; ++i) {
      rsi.v[i] = p_rng[i + 1];
    }
    if (NULL == sindex_str) {
      rng_split(&rsi, &rsi, sindex);
    } else {
      rng_split_cstr(&rsi, &rsi, sindex_str);
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

