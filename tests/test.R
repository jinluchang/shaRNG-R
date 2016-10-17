install.packages("shaRNG_0.1.tar.gz")

testRng <- function()
{
	print("test.rng")
	set.seed(0)
	seed0 <- getRngState()
	rs0 <- c(runif(3), rnorm(3))
	print(rs0)
	setRngState(seed0)
	rs0r <- c(runif(3), rnorm(3))
	print(paste("zero = ", rs0 - rs0r))
}

library(shaRNG)

print("initial")
getRngState()
c(runif(3), rnorm(3))

testRng()

useDefaultRng()

testRng()

print("initial 2")
useShaRng()
getRngState()
c(runif(3), rnorm(3))

print("initial 3")
useShaRng()
getRngState()
c(runif(3), rnorm(3))


getRngState()

rootRngState()

set.seed(0)

getRngState()

set.seed(10)

getRngState()

runif(1)
runif(1)
runif(1)

setRngState(splitRngState(rootRngState(), 10))

getRngState()

runif(1)
runif(1)
runif(1)

getRngState()

sample(10)

s <- getRngState()

s

s <- splitRngState(s, 10)

s

s <- splitRngState(s, "3")

s

setRngState(s)

c(runif(3), rnorm(3))

getRngState()

c(runif(3), rnorm(3))

splitRngEval("hello", rnorm(3))

splitRngEval("hello", rnorm(3))

"hello" %splitRngEval% {
	rnorm(3)
	rnorm(3)
}

splitRngEval("hello2", rnorm(3))

splitRngEval("hello", rnorm(6))

setSeedRngState(134)

# set.seed(134)

# setSplitRngState(getRngState(), 122)

runif(10)
rnorm(10)
runif(10)
rnorm(10)

