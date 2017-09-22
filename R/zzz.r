.pkgenv <- new.env(parent=emptyenv())

.onAttach <- function(...) {

  apps <- jsonlite::fromJSON(system.file("extdata", "apps.json", package = "rappalyzer"))
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

  assign("html", app_html, envir=.pkgenv)
  assign("script", app_script, envir=.pkgenv)
  assign("urls", app_urls, envir=.pkgenv)
  assign("meta", app_meta, envir=.pkgenv)
  assign("headers", app_headers, envir=.pkgenv)

}

