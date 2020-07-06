# this File: /home/jim/code/pkg_yt_api/R/yt_api_functions.R
# 
# REF: HADLEY has demos: oauth1 and oauth 2, various popular apis
# https://github.com/r-lib/httr/tree/master/demo


#' ---------
#' set_query
#' ---------
#' sets query portion of POST
#'
#' @param part
#' @param maxResults 
#' @param mine
#' @param fields
#' @param key
#' @return list
#' @export
set_query <- function(part,maxResults = 50,mine=NULL,fields=NULL,key, ...) {
	query <- list(part = part,
								maxResults = maxResults, 
								mine = mine,
								fields=fields,
								key = key,
								...
	)
}

#' ---------
#' set_config
#' ---------
#' @param token
#' @return 
#' @export

# ---------
set_config <- function(token) {
	config  <- httr::config(token =token) 
}


#' ----------------
#' function get_json
#' -----------------
#'
#' @param r
#' @return json_content
#' @export
#'
# get json of responsed
get_json <- function(r) {
	text_content <- httr::content(r,"text")
	json_content <- text_content %>% jsonlite::fromJSON()
}

#' ----------------
#' function nextPageToken
#' ----------------
#'
#' @param r
#' @return 
#' @export
#'
get_nextPageToken <- function(r) {
  httr::content(r)$nextPageToken
}

#' ---------
#' get_batch_videos
#' ---------
#'
#' @param base_url
#' @param query
#' @param config
#' @return
#' @export

get_batch_videos  <- function(base_url,query,config) {
			# get a block (upto maxResults)
			r <- httr::GET(url = base_url, 
											query= query, 
											config = config
			) %>% httr::stop_for_status()
}
