---
title: "010_comments.R"
output: 
  pdf_document
editor_options: 
  chunk_output_type: console
geometry: margin=0.3in
---

## from API Explorer / need API only

#### 001_get_comments, for GIVEN video
	load_all()

# ---- set once ----
api <- get_api_codes()
myapp  <- tuber::yt_oauth(app_id = api$oauth2_id,
													app_secret = api$oauth2_secret)
l <- get_typical_yt()
google_token  <- base::getOption("google_token")
base_url <- "https://www.googleapis.com/youtube/v3/commentThreads"

# NEED this?	
set_playlists <- function(l, base_url) {
	maxResults  <- l$maxResults
	playlistId  <- l$playlistId
	videoId  <- l$videoId
}
videoId <- l$videoId
maxResults <- l$maxResults
# ---------
query  <- set_query( part="snippet",
							maxResults =maxResults,
							mine = FALSE,
							fields="items(snippet(topLevelComment(snippet(videoId,textDisplay))))",
							key = api$api_key,
							pageToken = NULL,
							videoId = videoId)

config  <- set_config(google_token)

r <- httr::GET(base_url, 
               query = query,
							 config = config
               ) %>% httr::stop_for_status()

json_content <- get_json(r)
# WHY go through this?   varioius levels are 'empty' but structure still there
comments <- json_content$items$snippet$topLevelComment$snippet

comments[2] # returns subset (dataframe0
comments[[2]] # return chr vector
str(comments)
head(comments)

httr::content(r)

httr::content(r)$pageInfo$totalResults  # 130




##more batches ?
# ---- loop till no more token ---

while ( !is.null(get_nextPageToken(r)) ) {
query  <- set_query( part="snippet",
							maxResults =maxResults,
							mine = FALSE,
							fields="items(snippet(topLevelComment(snippet(videoId,textDisplay))))",
							key = api$api_key,
						  pageToken = get_nextPageToken(r),
							videoId = videoId)

r <- httr::GET(base_url, 
               query = query,
							 config = config
               ) %>% httr::stop_for_status()

json_content <- get_json(r)
next_comments <- json_content$items$snippet$topLevelComment$snippet

comments <- rbind(comments, next_comments)
}	# end loop

saveRDS(comments, file="data/comments.RDS")

t <- as_tibble(comments)
t

head(knitr::kable(t))



