check_html <- function(site_html) {

  if (inherits(site_html, "response")) {
    site_html <- s_content(site_html, as="text", encoding="UTF-8")
    if (is.null(site_html$result)) return(data_frame())
    site_html <- site_html$result
  }

  if (is.raw(site_html)) site_html <- readBin(site_html, character())

  app_html <- .pkgenv$html

  purrr::map(app_html, c("html", "main")) %>%
    map_lgl(~.x %~% site_html) %>%
    purrr::keep(`==`, TRUE) -> res

  if (length(res) > 0) {

    res <- data_frame(match_kind = "html", match_app = names(res))
    res

  } else {
    data_frame()
  }

}


