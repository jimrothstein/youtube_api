
#' ----------------
#' function get_json
#' -----------------
#'
#' @param r response
#' @return json_content
#' @export
#'
get_json <- function(r) {
  text_content <- httr::content(r,"text")
  json_content <- text_content %>% jsonlite::fromJSON()
}
