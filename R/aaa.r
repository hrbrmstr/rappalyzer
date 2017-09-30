# need these b/c network ops & HTML parsing are always fraught with peril
s_GET <- purrr::safely(httr::GET)
s_read_html <- purrr::safely(xml2::read_html)
s_content <- purrr::safely(httr::content)
