#include "rng-state-c.h"

#include "rng-state.h"

#include <cstdlib>

void rng_reset(RngStateInt32s* rsi)
{
  RngState rs;
  exportRngState(rsi->v, rs);
}

void rng_split(RngStateInt32s* rsi, const RngStateInt32s* rsi0, const long sindex)
{
  RngState rs;
  importRngState(rs, rsi0->v);
  splitRngState(rs, rs, sindex);
  exportRngState(rsi->v, rs);
}

void rng_split_cstr(RngStateInt32s* rsi, const RngStateInt32s* rsi0, const char* sindex)
{
  RngState rs;
  importRngState(rs, rsi0->v);
  splitRngState(rs, rs, sindex);
  exportRngState(rsi->v, rs);
}

double rng_runif(RngStateInt32s* rsi)
{
  RngState rs;
  importRngState(rs, rsi->v);
  double r = uRandGen(rs);
  exportRngState(rsi->v, rs);
  return r;
}

double rng_rnorm(RngStateInt32s* rsi)
{
  RngState rs;
  importRngState(rs, rsi->v);
  double r = gRandGen(rs);
  exportRngState(rsi->v, rs);
  return r;
}

