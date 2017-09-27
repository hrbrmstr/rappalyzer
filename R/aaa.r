# need these b/c HTML parsing is always fraught with peril
s_read_html <- purrr::safely(xml2::read_html)
s_content <- purrr::safely(httr::content)

# this helpes break up the regexes into some things we can use
separate_patterns <- function(x) {
  # cld be more than one regex per area of inspection
  purrr::map(x, ~{
    # split off the naemd match groups
    res <- flatten_chr(stri_split_fixed(.x, "\\;"))
    # modify regex for R/ore compatibility & then compile the regex
    ret <- list(pat = list(main = ore::ore(stri_replace_all_fixed(res[1], "[^]", "[\\^]"), options="i")))
    if (length(res) > 1) {
      fields <- stri_split_fixed(res[-1], ":", simplify = TRUE)
      ret$pat$attrs <- set_names(as.list(fields[,2]), fields[,1])
    }
    ret
  })
}

