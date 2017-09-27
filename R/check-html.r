check_html <- function(site_html) {

  if (inherits(site_html, "response")) {
    site_html <- s_content(site_html, as="text", encoding="UTF-8")
    if (is.null(site_html$result)) return(data_frame())
    site_html <- site_html$result
  }

  if (is.raw(site_html)) site_html <- readBin(site_html, character())

  app_html <- .pkgenv$html

  purrr::map(app_html, c("html", "pat")) %>%                                    # iterate over each site's patterns
    purrr::map(~{
      pat <- .x
      ret <- list(m = ore_search(pat$main, site_html, all=TRUE))                # check for a match
      ret$found <- !is.null(ret$m)
      if (ret$found) {
        if (!is.null(pat$attrs)) {
          for(i in 1:length(pat$attrs)) {                                         # iterate over attributes
            field <- names(pat$attrs[i])                                          # get the field name
            if (grepl("\\\\", pat$attrs[[i]])) {                                  # if match grp, extract
              match_grp <- as.numeric(gsub("\\", "", pat$attrs[[i]], fixed=TRUE))
              ret[field] <- ret$m[match_grp, 1]
            } else {                                                              # otherwise return val
              ret[field] <- pat$attrs[[i]]
            }
          }
        }
      }
      ret$m <- NULL
      ret$match_kind <-  "html"
      ret
    }) %>%
    keep(~.x$found) -> res

  if (length(res) > 0) {

    purrr::map_df(res, ~{ .x$found = NULL ; .x }, .id="match_app")

  } else {
    data_frame()
  }

}


