.pkgenv <- new.env(parent=emptyenv())

.onAttach <- function(...) {

  ctx <- V8::v8()
  ctx$assign("apps_in", paste0(readLines(system.file("extdata", "apps.json", package="rappalyzer")),
                                         collapse="\n"))
  ctx$source(system.file("js/wapmin.js", package="rappalyzer"))
  assign("ctx", ctx, envir=.pkgenv)

  a <- jsonlite::fromJSON(system.file("extdata", "apps.json", package="rappalyzer"))
  assign("cats", a$categories, envir=.pkgenv)

}