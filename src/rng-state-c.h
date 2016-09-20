#undef NDEBUG

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>

#define RNG_NUM_OF_INT32 22

typedef struct RngStateInt32s
{
  uint32_t v[RNG_NUM_OF_INT32];
} RngStateInt32s;

void rng_reset(RngStateInt32s* rsi);

void rng_split(RngStateInt32s* rsi, const RngStateInt32s* rsi0, const long sindex);

void rng_split_cstr(RngStateInt32s* rsi, const RngStateInt32s* rsi0, const char* sindex);

double rng_runif(RngStateInt32s* rsi);

double rng_rnorm(RngStateInt32s* rsi);

#ifdef __cplusplus
}
#endif
