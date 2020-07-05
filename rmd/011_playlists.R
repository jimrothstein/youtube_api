# /* vim: set nospell: */ 

# /home/jim/code/pkg_yt_api/exclude/011_playlists.R
load_all()

# ---- set once ----
api <- get_api_codes()
myapp  <- tuber::yt_oauth(app_id = api$oauth2_id,
													app_secret = api$oauth2_secret
)
l <- get_typical_yt()
google_token  <- base::getOption("google_token")
base_url <- "https://www.googleapis.com/youtube/v3/playlists"

# NEED this?	
set_playlists <- function(l, base_url) {
	maxResults  <- l$maxResults
	playlistId  <- l$playlistId
	video_id = l$video_id
}
maxResults <- l$maxResults
# ---------

query  <- set_query( part="snippet",
							maxResults =maxResults,
							mine = TRUE,
              fields="nextPageToken,items(id,snippet(title,description,channelId,publishedAt))",
							key = api$api_key,
							pageToken = NULL)


config  <- set_config(token = google_token)


r <- httr::GET(base_url, 
               query = query,
							 config = config
               ) %>% httr::stop_for_status()

json_content <- get_json(r)
# playlists is data.frame, 50 x 4
playlists <- json_content$items$snippet
str(playlists)
head(playlists)

##  sTART HERE
##more batches ?
# ---- loop till no more token ---

while ( !is.null(get_nextPageToken(r)) ) {

# only 1 change
pageToken <- get_nextPageToken(r)

query  <- set_query( part="snippet",
							maxResults =maxResults,
							mine = TRUE,
              fields="nextPageToken,items(id,snippet(title,description,channelId,publishedAt))",
							key = api$api_key,
							pageToken = pageToken)


config  <- set_config(token = google_token)

r <- httr::GET(base_url, 
               query = query,
               config = config 
               )


json_content <- get_json(r)
# claim:   playlists is data.frame, 50 x 2
next_playlists <- json_content$items$snippet
playlists <- rbind(playlists, next_playlists)
}
playlists
##

# google stores dates as ISO 8601, as string
# why need TWO lubridate commands to retrieve simple date?
playlists <- playlists %>% 
	dplyr::mutate(date= lubridate::as_date(
									lubridate::as_datetime(publishedAt))) %>% 
	dplyr::select(-c(channelId,publishedAt))

playlists


