.pkgenv <- new.env(parent=emptyenv())

.onAttach <- function(...) {

  ctx <- V8::v8()
  ctx$assign("apps_in", paste0(readLines("inst/extdata/apps.json"), collapse="\n"))
  ctx$source(system.file("js/wapmin.js", package="rappalyzer"))
  assign("ctx", ctx, envir=.pkgenv)

}