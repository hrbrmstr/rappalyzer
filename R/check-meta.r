check_meta <- function(site_html) {

  if (inherits(site_html, "response")) {
    site_html <- s_content(site_html, as="parsed", encoding="UTF-8")
    if (is.null(site_html$result)) return(data_frame())
    site_html <- site_html$result
  }

  if (inherits(site_html, "character")) {
    site_html <- s_read_html(site_html)
    if (is.null(site_html$result)) return(data_frame())
    site_html <- site_html$result
  }

  if (is.raw(site_html)) {
    site_html <- s_read_html(site_html)
    if (is.null(site_html$result)) return(data_frame())
    site_html <- site_html$result
  }

  meta_tags <- rvest::html_nodes(site_html, "meta[name]")

  set_names(as.list(rvest::html_attr(meta_tags, "content")),
            stri_trans_tolower(rvest::html_attr(meta_tags, "name"))) -> site_meta

  app_meta <- .pkgenv$meta

  purrr::map(app_meta, ~{
    targets <- intersect(names(.x$meta), names(site_meta))
    if (length(targets) > 0) {
      met <- .x$meta
      purrr::map(targets, ~{
        ret <- list(m = ore_search(met[[.x]]$pat$main, site_meta[[.x]]))
        ret$found <- !is.null(ret$m)
        if (ret$found) {
          if (!is.null(met[[.x]]$pat$attrs)) {
            for (i in 1:length(met[[.x]]$pat$attrs)) {
              field <- names(met[[.x]]$pat$attrs)
              if (grepl("\\\\", met[[.x]]$pat$attrs[[i]])) {
                match_grp <- suppressWarnings(as.numeric(gsub("\\", "", met[[.x]]$pat$attrs[[i]], fixed=TRUE)))
                ret[field] <- ret$m[match_grp, 1]
              } else {
                ret[field] <- met[[.x]]$pat$attrs[[i]]
              }
            }
          }
        }
        ret$m <- NULL
        ret$match_kind <-  "meta"
        ret
      }) %>%
        keep(~.x$found)
    }
  }) %>%
    discard(~length(.x) == 0) -> res

  if (length(res) > 0) {

    purrr::map_df(res, ~{
      lst <- .x
      purrr::map_df(lst, ~{ .x$found <- NULL ; .x })
    }, .id="match_app")

  } else {
    data_frame()
  }

}
