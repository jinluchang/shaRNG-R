RNG.get.state <- function() {
	return(.Random.seed)
}

RNG.set.state <- function(s) {
	.Random.seed <<- s
}

RNG.split.state <- function(s, i) {
	.Call("split_rng_state", s, i)
}
