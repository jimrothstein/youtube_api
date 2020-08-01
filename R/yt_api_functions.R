# this File: /home/jim/code/pkg_yt_api/R/yt_api_functions.R
# 
# REF: HADLEY has demos: oauth1 and oauth 2, various popular apis
# https://github.com/r-lib/httr/tree/master/demo
#' ---------
#' set_query
#' ---------
#'
#' @description
#' sets query portion of POST.
#'   * item1
#'   * item2
#'
#' Additional paragraph.   As much as you want.
#'
#' @param part defined_by_api.
#' @param maxResults number.
#' @param mine my_info.
#' @param fields api_specific
#' @param key api_specific
#' @return list
#' @export  
#' @examples
#' \dontrun{
#' set_query("......")
#' }

set_query <- function(part,maxResults = 50,mine=NULL,fields=NULL,key, ...) {
	.Depreciated("use list instead")
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
#' @param token permission
#' @return 
#' @export

# ---------
set_config <- function(token) {
	.Deprecated("no need to use a function")
	config  <- httr::config(token =token) 
}


#' ----------------
#' function get_json
#' -----------------
#'
#' @param r response
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
#' @param r response
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
#' @param base_url ur_provide_by_api
#' @param query  query_string
#' @param config  info related to "google_token"
#' @return
#' @export

get_batch_videos  <- function(base_url,query,config) {
			# get a block (upto maxResults)
			r <- httr::GET(url = base_url, 
											query= query, 
											config = config
			) %>% httr::stop_for_status()
}

#'-----------------
#' get_api_codes
#'-----------------
#'
#' @return
#' @export

get_api_codes  <- function() {
	api  <- list(api_key = Sys.getenv("API_KEY"),
				 oauth2_id = Sys.getenv("OAUTH2_ID"),
				 oauth2_secret = Sys.getenv("OAUTH2_SECRET"))
}

#'-----------------
#' get_typical_yt
#'-----------------

#' returns pre-set examples for channelId, playlistId, videoId
#'   and maxResults = 50
#' playlistId <- "PLbcglKxZP5PMBoG1VfCqlWZ1Nx4FBBOn6"  # 60s - female (300+)
#' videoId <- "UCVdHFHpFBg"   # Tex Ritter Range Party
#' @return list
#' @export
get_typical_yt  <- function(){
	values  <- list(
						maxResults = 50,
						channelId =  "UClB5qWyXejlAwwkDAzJis-Q", # my channel
						videoId = "bMaCoxOGXPM",   # You Made me Love You)
						playlistId = "PLbcglKxZP5PMU2rNPBpYIzLTgzd5aOHw2")
}

#'
#' get_oauth_endpoints
#'
#' returns google endpoints
#' @return list
#' @export

get_oauth_endpoints   <- function(x="google") {
	httr::oauth_endpoints(x)
}

