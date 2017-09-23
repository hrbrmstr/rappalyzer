check_headers <- function(site_headers) {

  if (inherits(site_headers, "response")) site_headers <- httr::headers(site_headers)

  site_headers <- set_names(site_headers, stri_trans_tolower(names(site_headers)))

  app_headers <- .pkgenv$headers

  purrr::map(app_headers, ~{
    targets <- intersect(names(.x$headers), names(site_headers))
    if (length(targets) > 0) {
      hdr <- .x$headers
      map_lgl(targets, ~hdr[[.x]]$main %~% site_headers[[.x]]) %>%
        keep(`==`, TRUE)
    }
  }) %>%
    purrr::discard(~length(.x) == 0) -> res

  if (length(res) > 0) {

    res <- data_frame(match_kind = "headers", match_app = names(res))
    res <- dplyr::distinct(res)

    res

  } else {
    data_frame()
  }

}
