# need these b/c HTML parsing is always fraught with peril
s_read_html <- purrr::safely(xml2::read_html)
s_content <- purrr::safely(httr::content)
