.pkgenv <- new.env(parent=emptyenv())

.onLoad <- function(...) {

  if (interactive()) packageStartupMessage("Building application inventory...")

  rebuild_apps_inventory(system.file("extdata", "apps.json", package = "rappalyzer"))

}

