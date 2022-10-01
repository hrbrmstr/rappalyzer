# need these b/c network ops & HTML parsing are always fraught with peril
s_GET <- purrr::safely(httr::GET)
s_read_html <- purrr::safely(xml2::read_html)
s_content <- purrr::safely(httr::content)

ua_chrome <- "Mozilla/5.0 (Macintosh) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36"

pkg_file <- function(...) {
  system.file(..., package = "rappalyzer")
}

read_pkg_file <- function(...) {
  paste0(readLines(system.file(..., package = "rappalyzer"), warn = FALSE), collapse = "\n")
}

setNames <- function (object = nm, nm) {
  names(object) <- nm
  object
}