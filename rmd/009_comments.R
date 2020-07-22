---
title: "009_comments.R"
output: 
  pdf_document
editor_options: 
  chunk_output_type: console
geometry: margin=0.3in
---

# ======================================
#### 001_get_comments, for GIVEN video
# ======================================
library(jimTools)
library(yt)
library(dplyr)
load_all()

# ====================
# ---- set once ----
# ====================
api <- get_api_codes()
myapp  <- tuber::yt_oauth(app_id = api$oauth2_id,
													app_secret = api$oauth2_secret)
l <- get_typical_yt()
google_token  <- base::getOption("google_token")
base_url <- "https://www.googleapis.com/youtube/v3/commentThreads"

# NEED -yes 	
maxResults  <- l$maxResults
playlist_Id  <- l$playlistId
video_Id  <- l$videoId

# ========
# QUERY 
# ========

query  <- set_query( part="snippet", 
	maxResults =maxResults, mine = FALSE,
	fields="nextPageToken,
					items(snippet(topLevelComment(snippet(videoId,textDisplay))))",
	key = api$api_key, pageToken = NULL, videoId = video_Id)

config  <- set_config(google_token)

r <- httr::GET(base_url, 
               query = query,
							 config = config
               ) %>% httr::stop_for_status()

json_content <- get_json(r)

# to get comments, wade through empty levels
comments <- json_content$items$snippet$topLevelComment$snippet
comments  <- as_tibble(comments)

#  FIX, pageInfo is not specified in fields
# httr::content(r)$pageInfo$totalResults  # 130

# ==================================
##more batches ?
# ---- loop till no more token ---
# ==================================

get_remainder  <- function(r) {
query  <- set_query( part="snippet",
							maxResults =maxResults,
							mine = FALSE,
							fields="nextPageToken, items(snippet(topLevelComment(snippet(videoId,textDisplay))))",
							key = api$api_key,
						  pageToken = get_nextPageToken(r),
							videoId = video_Id)

r <- httr::GET(base_url, 
               query = query,
							 config = config
               ) %>% httr::stop_for_status()
}


process_comments  <- function(r, comments) {
	json_content <- get_json(r)
	next_comments <- json_content$items$snippet$topLevelComment$snippet
	next_comments  <- as_tibble(next_comments)
	comments <- rbind(comments, next_comments)
}

# get remainder of videos
while ( !is.null(get_nextPageToken(r)) ) {
	r  <- get_remainder(r)
	comments  <- process_comments(r, comments)

} # end loop


saveRDS(comments, file="data/comments.RDS")

t <- as_tibble(comments)
t

head(knitr::kable(t))



