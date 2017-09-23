#' Provide the full path to the "icon" file within the package
#'
#' @md
#' @param icon_ref icon file name generally found in the `icon` column
#'        returned via a call to [rappalyze()].
#' @export
#' @examples
#' rapp_icon("Nginx.svg")
rapp_icon <- function(icon_ref) {
  system.file("extdata", "icons", icon_ref, package="rappalyzer")
}