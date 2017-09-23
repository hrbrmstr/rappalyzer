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