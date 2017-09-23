check_url <- function(site_url) {

  app_urls <- .pkgenv$urls

  purrr::map(app_urls, c("url", "main")) %>%
    map_lgl(~.x %~% site_url) %>%
    purrr::keep(`==`, TRUE) -> res

  if (length(res) > 0) {
    res <- data_frame(match_kind = "url", match_app = names(res))
    res
  } else {
    data_frame()
  }

}
