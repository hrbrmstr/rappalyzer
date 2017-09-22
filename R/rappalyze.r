#' Identify technologies used on a given site/URL
#'
#' @param site either a URL (which will be fetched with `httr::GET()`) or an `httr` `response` object
#' @param verbose display progress messages (some sites take a few seconds to analyze)
#' @export
#' @examples
#' rappalyze("https://rud.is/b")
#' rappalyze("https://www.quantcast.com")
#' rappalyze("https://wappalyzer.com")
rappalyze <- function(site, quiet = !interactive()) {

  ua_chrome <- "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36"
  if (!inherits(site, "response")) site <- httr::GET(site, httr::user_agent(ua_chrome))

  if (!quiet) message("Analyzing URL...")
  url_check <- check_url(site$url)

  if (!quiet) message("Analyzing server headers...")
  header_check <- check_headers(site)

  if (!quiet) message("Analyzing HTML content...")
  html_check <- check_html(site)

  if (!quiet) message("Analyzing <metga> tags...")
  meta_check <- check_meta(site)

  if (!quiet) message("Analyzing <script> tags...")
  script_check <- check_script(site)

  res <- dplyr::bind_rows(url_check, html_check, meta_check, script_check, header_check)
  res <- dplyr::distinct(res)

  if (nrow(res) > 0) res$url <- site$url

  res

}
