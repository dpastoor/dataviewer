required_packages <- c(
    "shiny",
    "shinydashboard",
    "DT"
)


available_packages <- vapply(required_packages, function(x) {
    try(requireNamespace(x, quietly = T))
}, logical(1))


needed_packages <- required_packages[!available_packages]

if(length(needed_packages) > 0) {
    message(paste("still need packages:", needed_packages, collapse = ","))
    message("trying to install packages from cran....")
}


install.packages(needed_packages)


