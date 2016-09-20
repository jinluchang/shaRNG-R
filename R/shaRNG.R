RNG.get.state <- function() {
	return(.Random.seed)
}

RNG.set.state <- function(state) {
	.Random.seed <<- state
}

RNG.root.state <- function() {
	.Call("root_rng_state")
}

RNG.split.state <- function(state, sindex) {
	.Call("split_rng_state", state, sindex)
}

RNG.seed.state <- function(seed) {
	RNG.split.state(RNG.root.state(), paste(seed, collapse=" ; "))
}

RNG.set.root.state <- function() {
	RNG.set.state(RNG.root.state())
}

RNG.set.seed.state <- function(seed) {
	RNG.set.state(RNG.seed.state(seed))
}

RNG.set.split.state <- function(state, sindex) {
	RNG.set.state(RNG.split.state(state, sindex))
}

RNG.save.eval <- function(expr) {
	old.state <- RNG.get.state()
	force(expr)
	RNG.set.state(old.state)
	return(expr)
}

RNG.split.eval <- function(sindex, expr) {
	RNG.save.eval({
		RNG.set.split.state(RNG.get.state(), sindex)
		force(expr)
	})
}

`%RNG.split.eval%` <- RNG.split.eval
