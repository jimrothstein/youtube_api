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

# set_query <- function(part,maxResults = 50,mine=NULL,fields=NULL,key, ...) {
#   .Deprecated("use list instead")
#   query <- list(part = part,
#                 maxResults = maxResults, 
#                 mine = mine,
#                 fields=fields,
#                 key = key,
#                 ...
#   )
# }

# ---------
# set_config
# ---------
# @param token permission
# @return 
# @export
# set_config <- function(token) {
#   .Deprecated("no need to use a function")
#   config  <- httr::config(token =token) 
# }



# ----------------
# function nextPageToken
# ----------------
#
# @param r response
# @return 
# @export
#
# get_nextPageToken <- function(r) {
#   .Deprecated("no need")
#   httr::content(r)$nextPageToken
# }


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
#'
get_oauth_endpoints   <- function(x="google") {
	httr::oauth_endpoints(x)
}

