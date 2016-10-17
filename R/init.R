.onLoad <- function(lib, pkg) {
	library.dynam("shaRNG", pkg, lib)
	useShaRng()
}

useShaRng <- function() {
    RNGkind("user", "user")
}

useDefaultRng <- function() {
	RNGkind("default", "default")
}

