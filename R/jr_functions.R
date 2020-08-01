#' jr_get_total_playlists returns number of playlists
#' @param query list built prior
#' @export
 jr_get_total_playlists  <- function(query){
 		httr::GET("https://www.googleapis.com/youtube/v3/playlists",
 							query= query,
 							httr::config(token= getOption("google_token"))
							)
 }


#' jr_get_batch_comments Given videoId, returns one batch comments 

#' @param base_url url for Google api
#' @param query list built prior
#' @param config embed token
#' @export
jr_get_batch_comments  <- function(base_url, query, config) {
	r <- httr::GET(base_url, 
								query = query,
								config = config
								) %>% httr::stop_for_status()

	json_content <- get_json(r)

	# to get comments, wade through empty levels
	comments <- json_content$items$snippet$topLevelComment$snippet
	comments  <- as_tibble(comments)
}

