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

check_html <- function(site_html) {

  if (inherits(site_html, "response")) site_html <- httr::content(site_html, as="text", encoding="UTF-8")
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

check_meta <- function(site_html) {

  if (inherits(site_html, "response")) site_html <- httr::content(site_html, as="parsed", encoding="UTF-8")
  if (inherits(site_html, "character")) site_html <- xml2::read_html(site_html)
  if (is.raw(site_html)) site_html <- xml2::read_html(site_html)

  meta_tags <- rvest::html_nodes(site_html, "meta[name]")

  set_names(as.list(rvest::html_attr(meta_tags, "content")),
            stri_trans_tolower(rvest::html_attr(meta_tags, "name"))) -> site_meta

  app_meta <- .pkgenv$meta

  purrr::map(app_meta, ~{
    targets <- intersect(names(.x$meta), names(site_meta))
    if (length(targets) > 0) {
      meta <- .x$meta
      map_lgl(targets, ~meta[[.x]]$main %~% site_meta[[.x]]) %>%
        keep(`==`, TRUE)
    }
  }) %>%
    purrr::discard(~length(.x)==0) -> res

  if (length(res) > 0) {
    res <- data_frame(match_kind = "meta", match_app = names(res))
    res
  } else {
    data_frame()
  }

}

check_script <- function(site_html) {

  if (inherits(site_html, "response")) site_html <- httr::content(site_html, as="parsed", encoding="UTF-8")
  if (inherits(site_html, "character")) site_html <- xml2::read_html(site_html)
  if (is.raw(site_html)) site_html <- xml2::read_html(site_html)

  src_nodes <- rvest::html_nodes(site_html, "script[src]")
  src <- rvest::html_attr(src_nodes, "src")

  body_nodes <- rvest::html_nodes(site_html, xpath=".//script[not(@src)]")
  body <- rvest::html_text(body_nodes)

  app_script <- .pkgenv$script

  purrr::map(app_script, c("script", "main")) %>%
    map_lgl(~{
      pat <- .x
      any(c(
        map_lgl(src, ~pat %~% .x),
        map_lgl(body, ~pat %~% .x)
      ))
    }) %>%
    purrr::keep(`==`, TRUE) -> res

  if (length(res) > 0) {
    res <- data_frame(match_kind = "script", match_app = names(res))
    res
  } else {
    data_frame()
  }

}

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
    purrr::discard(~length(.x)==0) -> res

  if (length(res) > 0) {
    res <- data_frame(match_kind = "headers", match_app = names(res))
    res <- dplyr::distinct(res)
    res
  } else {
    data_frame()
  }

}


