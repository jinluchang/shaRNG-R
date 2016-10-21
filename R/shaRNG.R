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
getRngState <- function() {
	return(.Random.seed)
}

setRngState <- function(state) {
	.Random.seed <<- state
}

#' set the state of all slaves to the same as master state
syncRng <- function(cl) {
	sync <- function(state) {
		library(shaRNG)
    setRngState(state)
	}
	clusterCall(cl, sync, getRngState())
	invisible(NULL)
}


#' get the root state
rootRngState <- function() {
	.Call("root_rng_state")
}

splitRngState <- function(state, sindex) {
	.Call("split_rng_state", state, sindex)
}

#' split a new state using the root state and seed
seedRngState <- function(seed) {
	splitRngState(rootRngState(), paste(seed, collapse=" ; "))
}

setRootRngState <- function() {
	setRngState(rootRngState())
}

setSeedRngState <- function(seed) {
	setRngState(seedRngState(seed))
}

setSplitRngState <- function(state, sindex) {
	setRngState(splitRngState(state, sindex))
}

jumpRng <- function(sindex = "") {
	setSplitRngState(getRngState(), sindex)
}

saveRngEval <- function(expr) {
	old.state <- getRngState()
	force(expr)
	setRngState(old.state)
	return(expr)
}

splitRngEval <- function(sindex, expr) {
	saveRngEval({
		setSplitRngState(getRngState(), sindex)
		force(expr)
	})
}

`%splitRngEval%` <- splitRngEval

#' @param root.state the start state for splitting,
#' which is an interger vector in
#' the form of .Random.seed. If state is NULL, then the current state of the
#' generator will be automatically used.
#' @param indices a vector of unique strings/integers for the indices of
#' each splitted stream.
#' @param n.stream desired number of splitted streams. A non-negative number,
#' which will be rounded down if fractional
#'
getSplitStates <- function(n.stream = NULL,
						   indices = seq(n.stream),
						   root.state = NULL) {

	if (is.null(root.state))
		root.state <- getRngState()
	sub.states <- lapply(indices, function(sindex)
						 splitRngState(root.state,
										 sindex))
	names(sub.states) <- indices
	return(list(sub.states = sub.states, root.state = root.state))
}


