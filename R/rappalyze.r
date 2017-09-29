ua_chrome <- "Mozilla/5.0 (Macintosh) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36"

#' Identify technologies used on a given site/URL
#'
#' Filenames returned in the `icon` column can be retrieved via the
#' [rapp_icon()] helper function.
#'
#' @md
#' @param site either a URL (which will be fetched with `httr::GET()`) or a "minimum vialbe"
#'        `httr` `response` object (which is a `list` with `url`, `headers` and raw `content`)
#' @param agent user agent to use. Ideally we'd be honest and say we're a bot. We don't since we
#'        are trying to find out what a site is using tech-wise.
#' @return data frame
#' @export
#' @examples
#' rappalyze("https://rud.is/b")
#' rappalyze("https://www.quantcast.com")
#' rappalyze("https://wappalyzer.com")
rappalyze <- function(site, agent = NULL) {

  agent <- if (is.null(agent)) ua_chrome else agent
  if (!inherits(site, "response")) site <- httr::GET(site, httr::user_agent(agent))

  .pkgenv$ctx$eval("var config = JSON.parse(apps_in);")
  .pkgenv$ctx$eval("var apps = config.apps;")
  .pkgenv$ctx$eval("var found = [];")
  .pkgenv$ctx$call("analyze", site$url, content(site, as="text", encoding="UTF-8"), site$headers)

  found <- .pkgenv$ctx$get("found", simplifyVector=FALSE, flatten=FALSE)

  if (length(found) > 0) {

    map_df(found, ~{

      conf <- if (length(.x$confidence) > 0) max(unlist(.x$confidence, use.names = FALSE)) else NA_real
      vers <-  if (.x$version == "") NA_character_ else .x$version

      data_frame(
        tech = .x$name,
        categories = .x$props$cats,
        match_type = .x$match_type,
        version = vers,
        confidence = conf
      )

    }) %>%
      distinct(tech, match_type, version, .keep_all=TRUE)

  } else {
    data_frame()
  }


}


