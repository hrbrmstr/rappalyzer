.pkgenv <- new.env(parent=emptyenv())

.onLoad <- function(...) {

  # if (interactive()) packageStartupMessage("Building application inventory...")
  #
  # rebuild_apps_inventory(system.file("extdata", "apps.json", package = "rappalyzer"))

  assign("rapp_join_df", rapp_join_df, envir=.pkgenv)
  # assign("apps", apps, envir=.pkgenv)
  assign("html", html, envir=.pkgenv)
  assign("script", script, envir=.pkgenv)
  assign("urls", urls, envir=.pkgenv)
  assign("meta", meta, envir=.pkgenv)
  assign("headers", headers, envir=.pkgenv)

}

