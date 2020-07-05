# /home/jim/code/pkg_yt_api/exclude/012_playlistitems.R

# ---- PURPOSE ----
# given a playlist, return list of videos
# ----------------

# 001_initalize
load_all()
myapp  <- tuber::yt_oauth(app_id = api$oauth2_id,
													app_secret = api$oauth2_secret)
base_url <- "https://www.googleapis.com/youtube/v3/playlistItems"
api  <- get_api_codes()
l <- get_typical_yt()
maxResults  <- l$maxResults
playlistId  <- l$playlistId
google_token = base::getOption("google_token") 
config  <- set_config(google_token)

#-----------------
# 002_setup call
query  <- set_query(part="snippet",
                maxResults=maxResults,
                playlistId=playlistId,
                pageToken="",
								mine=FALSE,
                fields=
"nextPageToken, items(snippet(title, description, position))",
                key=api$api_key)

# what is this?
config  <- set_config(google_token)

# videos <- get_all_videos(url,query,config)

r  <- get_batch_videos(url =base_url, query, config)

# process	j
			json_content <- get_json(r)
			videos <- json_content$items$snippet

# ---------
# if multiple blocks, loop
while ( !is.null(get_nextPageToken(r)) ) {
		query$pageToken  <- get_nextPageToken(r)
		r<- get_batch_videos(url = base_url, query,config)

		# process
		json_content <- get_json(r)
		next_videos <- json_content$items$snippet
		videos <- rbind(videos, next_videos)
}	# end loop

saveRDS(videos, file=here::here("data/videos.RDS"))
