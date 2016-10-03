install.packages("shaRNG_0.1.tar.gz")

test.rng <- function()
{
	print("test.rng")
	set.seed(0)
	seed0 <- RNG.get.state()
	rs0 <- c(runif(3), rnorm(3))
	print(rs0)
	RNG.set.state(seed0)
	rs0r <- c(runif(3), rnorm(3))
	print(paste("zero = ", rs0 - rs0r))
}

library(shaRNG)

print("initial")
RNG.get.state()
c(runif(3), rnorm(3))

test.rng()

RNG.use.default()

test.rng()

print("initial 2")
RNG.use.sha()
RNG.get.state()
c(runif(3), rnorm(3))

print("initial 3")
RNG.use.sha()
RNG.get.state()
c(runif(3), rnorm(3))


RNG.get.state()

RNG.root.state()

set.seed(0)

RNG.get.state()

set.seed(10)

RNG.get.state()

runif(1)
runif(1)
runif(1)

RNG.set.state(RNG.split.state(RNG.root.state(), 10))

RNG.get.state()

runif(1)
runif(1)
runif(1)

RNG.get.state()

sample(10)

s <- RNG.get.state()

s

s <- RNG.split.state(s, 10)

s

s <- RNG.split.state(s, "3")

s

RNG.set.state(s)

c(runif(3), rnorm(3))

RNG.get.state()

c(runif(3), rnorm(3))

RNG.split.eval("hello", rnorm(3))

RNG.split.eval("hello", rnorm(3))

"hello" %RNG.split.eval% {
	rnorm(3)
	rnorm(3)
}

RNG.split.eval("hello2", rnorm(3))

RNG.split.eval("hello", rnorm(6))

RNG.set.seed.state(134)

# set.seed(134)

# RNG.set.split.state(RNG.get.state(), 122)

runif(10)
rnorm(10)
runif(10)
rnorm(10)

