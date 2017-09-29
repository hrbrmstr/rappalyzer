#' Rebuild apps inventory with a different master file
#'
#' The source `apps.json` file in the [Wappalyzer repo](https://raw.githubusercontent.com/AliasIO/Wappalyzer/master/src/apps.json)
#' changes more frequently than the one that comes with the package. Use
#' this function to rebuild the in-memory data structures that support
#' the parsing and technology stack detection functions.
#'
#' @md
#' @param apps_js_file path to a new application inventory file
#' @export
#' @examples \dontrun{
#' wapp_url <- "https://raw.githubusercontent.com/AliasIO/Wappalyzer/master/src/apps.json"
#' tf <- tempfile()
#' download.file(wapp_url, tf)
#' rebuild_apps_inventory(tf)
#' unlink(tf)
#' }
rebuild_apps_inventory <- function(apps_js_file) {

  apps_js_file <- path.expand(apps_js_file)

  apps <- jsonlite::fromJSON(apps_js_file)

  app_name <- names(apps$apps)
  for (i in 1:length(apps$apps)) apps$apps[[i]]$app_name <- app_name[i]

  discard(apps$apps, ~length(.x$headers)==0) %>%
    map(~{
      list(
        headers = set_names(separate_patterns(.x$headers), tolower(names(.x$headers))),
        app_name = .x$app_name
      )}
    ) -> app_headers

  discard(apps$apps, ~length(.x$meta)==0) %>%
    map(~{
      list(
        meta = set_names(separate_patterns(.x$meta), tolower(names(.x$meta))),
        app_name = .x$app_name
      )}
    ) -> app_meta

  discard(apps$apps, ~length(.x$url)==0) %>%
    map(~{
      list(
        url = unlist(separate_patterns(.x$url), recursive = FALSE),
        app_name = .x$app_name
      )}
    ) -> app_urls

  discard(apps$apps, ~length(.x$script)==0) %>%
    map(~{
      list(
        script = unlist(separate_patterns(.x$script), recursive = FALSE),
        app_name = .x$app_name
      )}
    ) -> app_script

  discard(apps$apps, ~length(.x$html)==0) %>%
    map(~{
      list(
        html = unlist(separate_patterns(.x$html), recursive = FALSE),
        app_name = .x$app_name
      )}
    ) -> app_html

  map_df(apps$apps, ~{
    data_frame(
      match_app = .x$app_name,
      implies = list(.x$implies %||% NA_character_),
      icon = .x$icon %||% NA_character_,
      cat_name = purrr::map(.x$cats, ~apps$categories[[.x]]$name),
      cat_priority = purrr::map(.x$cats, ~apps$categories[[.x]]$priority)
    )
  }) -> rapp_join_df

  assign("rapp_join_df", rapp_join_df, envir=.pkgenv)
  # assign("apps", apps, envir=.pkgenv)
  assign("html", app_html, envir=.pkgenv)
  assign("script", app_script, envir=.pkgenv)
  assign("urls", app_urls, envir=.pkgenv)
  assign("meta", app_meta, envir=.pkgenv)
  assign("headers", app_headers, envir=.pkgenv)

}
