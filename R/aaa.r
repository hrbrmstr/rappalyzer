separate_patterns <- function(x) {
  map(x, ~{
    res <- flatten_chr(stri_split_fixed(.x, "\\;"))
    ret <- list(main = ore::ore(stri_replace_all_fixed(res[1], "[^]", "[\\^]")), options="i")
    if (length(res) > 1) {
      fields <- stri_split_fixed(res[-1], ":", simplify = TRUE)
      ret$attrs <- set_names(as.list(fields[,2]), fields[,1])
    }
    ret
  })
}

