
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

