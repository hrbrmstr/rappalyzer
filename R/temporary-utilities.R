#' Wappalyzer Categories (TEMPORARY HELPER)
#'
#' @export
wap_categories <- function() {
  jsonlite::fromJSON(pkg_file("extdata", "categories.json"))
}

#' Wappalyzer Applications (TEMPORARY HELPER)
#'
#' @export
wap_application <- function() {
  jsonlite::fromJSON(pkg_file("extdata", "apps.json"))
}

#' Wappalyzer Groups (TEMPORARY HELPER)
#'
#' @export
wap_groups <- function() {
  jsonlite::fromJSON(pkg_file("extdata", "groups.json"))
}