#' helper functions to add video to playlist

#' ===========
#' set_body
#' ===========

#' helper function: set_body 
#' prepare data portion of query to yt

#' @return
#' @export 

set_body  <- function(video_id, playlist_id){
	# 
	glue::glue(.open= "<"  ,
						 .close= ">" ,
						 '{"snippet":{"playlistId":"<playlist_id>","position":0,"resourceId":{"kind":"youtube#video","videoId":"<video_id>"}}}'
	) 
}


#' ============
#' add_video
#' ============

#' @return
#' @export

add_video  <- function(url, query, body, config) {
r <- httr::POST(url=base_url, 
								query =  query,
								body = body,
								encode="json",
								config = config
								)
}
