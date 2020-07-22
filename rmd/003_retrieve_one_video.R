# /* vim: set nospell: */ 

# /home/jim/code/pkg_yt_api/exclude/003_retrieve_one_video.R

#-----------------

if (!exists("api")) api <- get_api_codes()

# initial global values | set .httr_oauth

# don't want to keep typing this
l <- get_typical_yt()
maxResults  <- l$maxResults
playlistId  <- l$playlistId
video_id = l$videoId
#### 003_youtube_api_retrieve_one_video
base_url <- "https://www.googleapis.com/youtube/v3/videos"

api_opts <- list(part = "snippet",
                 id = video_id,
                 maxResults = maxResults,
                 fields="items(snippet(title))",
                 key = api$api_key)

r <- httr::GET(base_url, query = api_opts) 
httr::content(r)

