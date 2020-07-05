# 014_add_to_playlist.R


# curl --request POST \
#   'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&key=[YOUR_API_KEY]' \
#   --header 'Authorization: Bearer [YOUR_ACCESS_TOKEN]' \
#   --header 'Accept: application/json' \
#   --header 'Content-Type: application/json' \
#   --data '{"snippet":{"playlistId":"YOUR_PLAYLIST_ID","position":0,"resourceId":{"kind":"youtube#video","videoId":"M7FIvfx5J10"}}}' \
#   --compressed
# 


# ---- PURPOSE ----
# given a playlist, add a video 
# ----------------

# =============
## EXPERIMENT
# =============

p_id  <- "PLAYLIST"
v_id   <- "M7FIv"

s  <- glue::glue(.open= "<"  ,
								 .close= ">"    ,
								 '{"snippet":{"playlistId":"<p_id>","position":0,"resourceId":{"kind":"youtube#video","videoId":"<v_id>"}}}') 

s 


# 001_initalize
# ===============
here()

load_all()

api  <- get_api_codes()
myapp  <- tuber::yt_oauth(app_id = api$oauth2_id,
													app_secret = api$oauth2_secret)

base_url <- "https://www.googleapis.com/youtube/v3/playlistItems"


google_token = base::getOption("google_token") 
config  <- set_config(google_token)

## current download1
##
# https://www.youtube.com/playlist?list=PLbcglKxZP5PMZ7afIT7E2o9NwQIzqTI5l
playlistId  <- "PLbcglKxZP5PMZ7afIT7E2o9NwQIzqTI5l"
##

# =================
# 002_setup call
# ================
query  <- set_query(part="snippet",
                key=api$api_key)

config  <- set_config(google_token)

# ==========
# SET BODY
# ==========

set_body  <- function(playlistId, videoId) {
# use glue
body  <-
	'{"snippet":{"playlistId":"YOUR_PLAYLIST_ID","position":0,"resourceId":{"kind":"youtube#video","videoId":"M7FIvfx5J10"}}}' 

}
set_body()


# ===========
# ADD VIDEO
# ===========

add_video  <- function(url, query, body, config) {


r <- httr::POST(url=base_url, 
								query =  query,
								body = body,
								encode="json",
								config = config
								)
}
add_video()
httr::content(r)
