.pkgenv <- new.env(parent=emptyenv())

.onAttach <- function(...) {

  ctx <- V8::v8()

  # load main wappalyzer module
  ctx$source(pkg_file("js", "wappalyzer.js"))

  # load categories
  ctx$assign(
    name = "cat_raw",
    value = read_pkg_file("extdata", "categories.json")
  )

	# instantiatee categories
	ctx$eval("var categories = JSON.parse(cat_raw);")

  # load technologies
	ctx$eval("var tech_pre = [];")

  ltrs <- c("_", letters)
	for (ltr in ltrs) {
    ctx$assign(sprintf("p_%s", ltr), read_pkg_file("extdata", "technologies", sprintf("%s.json", ltr)))
	}

	for (ltr in ltrs) {
		ctx$eval(sprintf("tech_pre['%s'] = p_%s;", ltr, ltr))
	}

  # instantiate categories
	ctx$eval("var technologies = {}")

 ctx$eval("
 for (const index of Array(27).keys()) {
  const character = index ? String.fromCharCode(index + 96) : '_'

	technologies = {
		...technologies,
		...JSON.parse(tech_pre[character]),
	}
}
")

  assign("ctx", ctx, envir=.pkgenv)


}