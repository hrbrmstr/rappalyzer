check_headers <- function(site_headers) {

  if (inherits(site_headers, "response")) site_headers <- httr::headers(site_headers)

  site_headers <- set_names(site_headers, stri_trans_tolower(names(site_headers)))

  app_headers <- .pkgenv$headers

  purrr::map(app_headers, ~{
    targets <- intersect(names(.x$headers), names(site_headers))
    if (length(targets) > 0) {
      hdr <- .x$headers
      purrr::map(targets, ~{
        ret <- list(m = ore_search(hdr[[.x]]$pat$main, site_headers[[.x]]))
        ret$found <- !is.null(ret$m)
        if (ret$found) {
          if (!is.null(hdr[[.x]]$pat$attrs)) {
            for (i in 1:length(hdr[[.x]]$pat$attrs)) {
              field <- names(hdr[[.x]]$pat$attrs)
              if (grepl("\\\\", hdr[[.x]]$pat$attrs[[i]])) {
                match_grp <- suppressWarnings(as.numeric(gsub("\\", "", hdr[[.x]]$pat$attrs[[i]], fixed=TRUE)))
                ret[field] <- ret$m[match_grp, 1]
              } else {
                ret[field] <- hdr[[.x]]$pat$attrs[[i]]
              }
            }
          }
        }
        ret$m <- NULL
        ret$match_kind <-  "headers"
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


