# /home/jim/code/pkg_yt_api/exclude/010_playlists_count.R

# Given a channelId, returns total number of playlists
# ---- set once ----
load_all()
api <- get_api_codes()
myapp  <- tuber::yt_oauth(app_id = api$oauth2_id,
													app_secret = api$oauth2_secret
)
google_token  <- base::getOption("google_token")
base_url <- "https://www.googleapis.com/youtube/v3/playlists"

# NEED?	initial global values
l <- get_typical_yt()

# ---------
query  <- set_query( part="snippet",
							maxResults =2,
							mine = TRUE,
							fields = "pageInfo(totalResults)",
							key = api$api_key)

config <- set_config(token=google_token)

# ---------
r <- httr::GET(base_url,
							 query=query, 
							 config= config) 

httr::stop_for_status(r, "GET")
json_content  <- get_json(r)
count  <- json_content$pageInfo$totalResults

