#' Path to 'volcano.tif'
#'
#' Just a file path for testing with
#'
#' @return character string ('/path/to/volcano.tif')
#' @export
#'
#' @examples
#' volcano.tif()
volcano.tif <- function() {
  system.file("extdata/volcano.tif", package = "volcano", mustWork = TRUE)
}
