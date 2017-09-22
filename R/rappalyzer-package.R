#' Identify Technologies Used On Websites
#'
#' The 'Wappalyzer' project <https://wappalyzer.com/> maintains a database
#' of features that can be compared and combined to identify what technologies -- servers,
#' frameworks, analytics tools, etc. -- are being used by a target web site. Methods are
#' provided that mimic the functionality of 'Wappalyzer' in R.
#'
#' @name rappalyzer
#' @docType package
#' @author Bob Rudis (bob@@rud.is)
#' @import stringi ore purrr httr
#' @importFrom xml2 read_html
#' @importFrom rvest html_nodes html_attr html_text
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr data_frame as_data_frame bind_rows distinct
NULL
