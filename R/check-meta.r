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
    purrr::discard(~length(.x) == 0) -> res

  if (length(res) > 0) {
    res <- data_frame(match_kind = "meta", match_app = names(res))
    res
  } else {
    data_frame()
  }

}
