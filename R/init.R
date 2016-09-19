.onLoad <- function(lib, pkg) {
	library.dynam("shaRNG", pkg, lib)
	RNG.use.sha()
}

RNG.use.sha <- function() {
    RNGkind("user", "user")
}

RNG.use.default <- function() {
	RNGkind("default", "default")
}

