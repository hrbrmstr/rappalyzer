check_script <- function(site_html) {

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

  src_nodes <- rvest::html_nodes(site_html, "script[src]")
  srcs <- paste0(rvest::html_attr(src_nodes, "src"), collapse="\n")

  body_nodes <- rvest::html_nodes(site_html, xpath=".//script[not(@src)]")
  body <- paste0(rvest::html_text(body_nodes), collapse="\n")

  app_script <- .pkgenv$script

  purrr::map(app_script[1:2], c("script", "pat")) %>%                                    # iterate over each site's patterns
    purrr::map(~{
      pat <- .x
      ret <- list(m = ore_search(pat$main, srcs, all=TRUE))                # check for a match
      ret$found <- !is.null(ret$m)
      if (ret$found) {
        if (!is.null(pat$attrs)) {
          for(i in 1:length(pat$attrs)) {                                         # iterate over attributes
            field <- names(pat$attrs[i])                                          # get the field name
            if (grepl("\\\\", pat$attrs[[i]])) {                                  # if match grp, extract
              match_grp <- suppressWarnings(as.numeric(gsub("\\", "", pat$attrs[[i]], fixed=TRUE)))
              ret[field] <- ret$m[match_grp, 1]
            } else {                                                              # otherwise return val
              ret[field] <- pat$attrs[[i]]
            }
          }
        }
      }
      ret$m <- NULL
      ret$match_kind <-  "script"
      ret
    }) %>%
    keep(~.x$found) -> res1

  purrr::map(app_script, c("script", "pat")) %>%                                    # iterate over each site's patterns
    purrr::map(~{
      pat <- .x
      ret <- list(m = ore_search(pat$main, body, all=TRUE))                # check for a match
      ret$found <- !is.null(ret$m)
      if (ret$found) {
        if (!is.null(pat$attrs)) {
          for(i in 1:length(pat$attrs)) {                                         # iterate over attributes
            field <- names(pat$attrs[i])                                          # get the field name
            if (grepl("\\\\", pat$attrs[[i]])) {                                  # if match grp, extract
              match_grp <- suppressWarnings(as.numeric(gsub("\\", "", pat$attrs[[i]], fixed=TRUE)))
              ret[field] <- ret$m[match_grp, 1]
            } else {                                                              # otherwise return val
              ret[field] <- pat$attrs[[i]]
            }
          }
        }
      }
      ret$m <- NULL
      ret$match_kind <-  "script"
      ret
    }) %>%
    keep(~.x$found) -> res2

  res <- c(res1, res2)

  if (length(res) > 0) {

    purrr::map_df(res, ~{ .x$found = NULL ; .x }, .id="match_app")

  } else {
    data_frame()
  }

}
