# this File: /home/jim/code/pkg_yt_api/R/yt_api_functions.R
# 
# REF: HADLEY has demos: oauth1 and oauth 2, various popular apis
# https://github.com/r-lib/httr/tree/master/demo

#"-----------------
#' function get_api_codes
#"-----------------
#'
#' @return
#' @export

get_api_codes  <- function() {
	api  <- list(api_key = Sys.getenv("API_KEY"),
				 oauth2_id = Sys.getenv("OAUTH2_ID"),
				 oauth2_secret = Sys.getenv("OAUTH2_SECRET"))
}

#"-----------------
#' function get_typical_yt
#"-----------------
#' DECRECATED - do not use 
#' @return
#' @export
#'
get_typical_yt  <- function(){
	values  <- list(maxResults = 50,
						channelId =  "UClB5qWyXejlAwwkDAzJis-Q", # my channel
						playlistId = "PLbcglKxZP5PMU2rNPBpYIzLTgzd5aOHw2", # 60s (124)
						videoId = "bMaCoxOGXPM" )  # You Made me Love You)
						# playlistId <- "PLbcglKxZP5PMBoG1VfCqlWZ1Nx4FBBOn6"  # anova(15)
						# videoId <- "UCVdHFHpFBg"   # Tex Ritter Range Party
}


#' ---------
#' set_query
#' ---------
#' sets query portion of POST
#'
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
#'
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
#' @return
#' @export

get_batch_videos  <- function(url,query,config) {
			# get a block (upto maxResults)
			r <- httr::GET(url = base_url, 
											query= query, 
											config = config
			) %>% httr::stop_for_status()
}
