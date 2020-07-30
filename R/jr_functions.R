#' jr_get_total_playlists returns number of playlists
#' @param query list built prior
#' @export

 jr_get_total_playlists  <- function(query){
 		httr::GET("https://www.googleapis.com/youtube/v3/playlists",
 							query= query,
 							httr::config(token= getOption("google_token"))
							)
 }


