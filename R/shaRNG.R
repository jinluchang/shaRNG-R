#' Splittable pseudo random number generator
#'
#'
#' @description Provides a random number generator based on sha2
#' which enables easy generation of independent and parallel
#' pseudo random number substreams
#'
#' @docType package
#' @name shaRNG_package
NULL


#' Get current state of the RNG
#'
#' @return current state, which is
#' the integer vector of the current value of \code{.Random.seed}. For
#' more details, see \code{\link{.Random.seed}}.
#'
RNG.get.state <- function() {
	return(.Random.seed)
}

RNG.set.state <- function(state) {
	.Random.seed <<- state
}

RNG.sync <- function(cl = NULL) {
	sync <- function(state) {
		library(shaRNG)
		RNG.set.state(state)
	}
	clusterCall(cl, sync, RNG.get.state())
	invisible(NULL)
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

RNG.jump <- function(sindex = "") {
	RNG.set.split.state(RNG.get.state(), sindex)
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

#' @param root.state the start state for splitting,
#' which is an interger vector in
#' the form of .Random.seed. If state is NULL, then the current state of the
#' generator will be automatically used.
#' @param indices a vector of unique strings/integers for the indices of
#' each splitted stream.
#' @param n.stream desired number of splitted streams. A non-negative number,
#' which will be rounded down if fractional
#'
GetSplitStates <- function(n.stream = NULL,
						   indices = seq(n.stream),
						   root.state = NULL) {

	if (is.null(root.state))
		root.state <- RNG.get.state()
	sub.states <- lapply(indices, function(sindex)
						 RNG.split.state(root.state,
										 sindex))
	names(sub.states) <- indices
	return(list(sub.states = sub.states, root.state = root.state))
}


