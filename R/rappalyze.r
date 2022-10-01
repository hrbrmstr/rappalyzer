#' Identify technologies used on a given site/URL
#'
#' Filenames returned in the `icon` column can be retrieved via the
#' [rapp_icon()] helper function.
#'
#' @md
#' @param site either a URL (which will be fetched with `httr::GET()`) or a "minimum viable"
#'        `httr` `response` object (which is a `list` with `url`, `headers` and raw `content`)
#' @param agent user agent to use. Ideally we'd be honest and say we're a bot. We don't since we
#'        are trying to find out what a site is using tech-wise.
#' @return data frame
#' @export
#' @examples
#' rappalyze("https://rud.is/b")
#' rappalyze("https://www.quantcast.com")
rappalyze <- function(site, agent = NULL) {

  agent <- if (is.null(agent)) ua_chrome else agent

  if (!inherits(site, "response")) {

    site_contents <- s_GET(site, httr::user_agent(agent))

    if (!is.null(site_contents$error)) {
      stop("Error retrieving contents of'", site, "'.", call. = FALSE)
    }

    if (is.null(site_contents$result)) return(tibble())

    httr::stop_for_status(site_contents$result)

    site_contents <- site_contents$result

  } else {
    site_contents <- site
  }

  # setup wappalyzer
  .pkgenv$ctx$eval("
var found_tech = {};

Wappalyzer.setTechnologies(technologies);
Wappalyzer.setCategories(categories);

var wappIt = function(url, html, meta, headers, script_src, cookies) {

	found_tech = Wappalyzer.analyze({
	  url: url,
    meta: meta,
    headers: headers,
    scriptSrc: script_src,
    cookies: cookies,
  	html: html
  });

  found_tech = Wappalyzer.resolve(found_tech);

}
")

  suppressMessages(parsed <- httr::content(site_contents))
  suppressMessages(plain <- httr::content(site_contents, as = "text"))

  meta <- rvest::html_nodes(parsed, xpath=".//meta[@name and @content]")

  if (length(meta) == 0) {
    meta <- V8::JS(jsonlite::toJSON(c()))
  } else {

    V8::JS(
      jsonlite::toJSON(
        as.list(
          setNames(
            rvest::html_attr(meta, "content"),
            rvest::html_attr(meta, "name")
          )
        ),
        auto_unbox = FALSE
      )
    ) -> meta

  }

  script_src <- rvest::html_nodes(parsed, xpath=".//script[@src]")
  script_src <- rvest::html_attr(script_src, "src")
  script_src <- basename(script_src)

  if (nrow(site_contents$cookies) == 0) {
    cookies <- V8::JS(jsonlite::toJSON(c()))
  } else {
    V8::JS(
      jsonlite::toJSON(
        as.list(setNames(site_contents$cookies$value, site_contents$cookies$name)),
        auto_unbox = FALSE
      )
    ) -> cookies
  }

  if (length(script_src) == 0) script_src <- list()

  .pkgenv$ctx$call(
    "wappIt",
    site_contents$url,
    meta,
    plain,
    V8::JS(jsonlite::toJSON(site_contents$headers, auto_unbox = FALSE, pretty = TRUE)),
    V8::JS(jsonlite::toJSON(script_src)),
    cookies
  )

  found_tech <- .pkgenv$ctx$get("found_tech", simplifyVector = FALSE, flatten = FALSE)

  if (length(found_tech) == 0) {
    data.frame()
  } else {

    purrr::map_df(found_tech, ~{

      if (length(.x$cpe) == 0) .x$cpe <- NA_character_

      .x$categories <- list(dplyr::bind_rows(.x$categories))
      .x$pricing <- list(.x$pricing)

      .x

    })

  }

}


