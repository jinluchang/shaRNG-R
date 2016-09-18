.onLoad <- function(lib, pkg) {
	library.dynam("shaRNG", pkg, lib)
    RNGkind("user", "user")
}


