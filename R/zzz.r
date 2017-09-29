.pkgenv <- new.env(parent=emptyenv())

.onAttach <- function(...) {

  if (interactive()) packageStartupMessage("Building application inventory...")

  rebuild_apps_inventory(system.file("extdata", "apps.json", package = "rappalyzer"))

}

