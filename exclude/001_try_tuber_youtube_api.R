# 001_try_tuber_youtube_api.R
## EXAMPLES:   using vanilla tuber, without httr

### my Google credentials: https://console.cloud.google.com/apis/credentials?project=sunny-aleph-164504

### References
# youtube api:  https://developers.google.com/youtube/v3/getting-started
# 

# using google api explorer:
# https://developers.google.com/youtube/v3/docs/?apix=true

#R-bloggers example: https://www.r-bloggers.com/using-the-tuber-package-to-analyse-a-youtube-channel/ 
#-  tuber: https://soodoku.github.io/tuber/articles/tuber-ex.html
#



#### 03_google setup
# click on my picture (in youtube)
# my channel_id=UClB5qWyXejlAwwkDAzJis-Q

# my google credentials,   google will then verify
api <- get_api_codes()
library(tuber)

yt_oauth(
app_id = api$oauth2_id,
app_secret = api$oauth2_secret
)

# some samples:

#channel_id <- "UClB5qWyXejlAwwkDAzJis-Q" # my channel
#video_id <- "UCVdHFHpFBg"   # Tex Ritter Range Party

#### 04_video - works
```{r}
video_id <- "UCVdHFHpFBg"   # Tex Ritter Range Party
a <- get_stats(video_id=video_id)

x <- as_tibble(a)   # works
x
# but
y <- tibble(a)   #  leaves as list

details <- get_video_details(video_id = video_id )
d <- as_tibble(details)

# get title
d$items[[1]]$snippet$title

str(details$items[[1]]$snippet, max.level =1)
glimpse(d$items)
d$items[[1]]$kind

```


#### 05_channel_all_playlists
```{r}
z <- tibble(get_playlists(
    filter=c(channel_id="UClB5qWyXejlAwwkDAzJis-Q"),
    part="snippet,contentDetails",
    max_results = 10,
    simplify=TRUE)
)
# NOTE: use of fields=   
# cutback on quota use, 
z <- tibble(response=get_playlists(
    filter=c(channel_id="UClB5qWyXejlAwwkDAzJis-Q"),
    part="snippet",
    max_results = 10,
    simplify=TRUE,
    fields="items(id,snippet(title,position))")
)

# EXPLORE - using JennyBC basic ideas
z$response[[1]]
z$response[[ 2 ]]
z$response[[ 3 ]]
z$response[[ 4 ]] # 129 results?
z$response[[ 5 ]] # mess,  but what we want

# get a feel:  $snippet looks good
z$response[[5]][[1]] %>% str(max.level=1)
o
# snippet$title is what we want!
z$response[[5]][[1]]$snippet  %>% str(max.level=1)
z$response[[5]][[10]]$snippet  %>% str(max.level=1)

# ALL MY PLAYLISTS <chr[]>
# bingo!  c("snippet", "title") is walking down tree....
map_chr(z$response[[5]],c("snippet","title"))
```

#### 06_list_channel_videos (ID only?)
```{r}

# my channel_id=UClB5qWyXejlAwwkDAzJis-Q
channel_id <- "UClB5qWyXejlAwwkDAzJis-Q" # mine
channel_id <- "UCT5Cx1l4IS3wHkJXNyuj4TA"
z<-list_channel_videos(channel_id=channel_id,
                       max_results = 4  )
z<-list_channel_videos(max_results = 4, mine=TRUE  )
z
```

#### channel, pick playlist, show videos
```{r}
filter=c(channel_id="UClB5qWyXejlAwwkDAzJis-Q")


# choose ONE
## my channel
#channel_id <- "UClB5qWyXejlAwwkDAzJis-Q"

# code example
channel_id <- "UCT5Cx1l4IS3wHkJXNyuj4TA"



a <- list_channel_resources(filter =  c(channel_id=channel_id),
                            part="contentDetails")

# 
playlist_id <- a$items[[1]]$contentDetails$relatedPlaylists$uploads

# Get videos on the playlist, data.frame
vids <- get_playlist_items(filter= c(playlist_id=playlist_id)) 


# as vector
# Video ids
vid_ids <- as.vector(vids$contentDetails.videoId)

# Function to scrape stats for all vids
get_all_stats <- function(id) {
  get_stats(id)
} 

# returns list
res <- map(vid_ids, get_all_stats)

as_tibble(res)
```

#### playlist
```{r}
get_stats(video_id="N708P-A45D0")

# "toDownload"
t <- tibble(get_playlist_items(
    filter = c(playlist_id ="PLbcglKxZP5PMDe2rhvTaahCV3BzFurnYJ"),
    part="contentDetails",
    simplify = TRUE) # return df
)
t %>% head(kind)
glimpse(t)
```

#### yt_search .... baffled how works
```{r}
# my channel?   UClB5qWyXejlAwwkDAzJis-Q
# = Channel stats = #
chstat = get_channel_stats("UClB5qWyXejlAwwkDAzJis-Q")

# = Videos = #
videos = yt_search(term="", type="video", channel_id = "UClB5qWyXejlAwwkDAzJis-Q")

videos = videos %>%
  mutate(date = as.Date(publishedAt)) %>%
  arrange(date)

```


Works
try short playlist
```{r}
# koreader (2 videos)
#list=PLbcglKxZP5PNQf6pOEfQ7LNsGSvSULa1a

v <- get_playlist_items(filter = c(playlist_id="PLbcglKxZP5PNQf6pOEfQ7LNsGSvSULa1a"), 
                        part="snippet",
                   max_results = 51)
t <- as_tibble(v)

glimpse(t)
t %>% select(snippet.title, snippet.publishedAt) %>% knitr::kable()
```


Longer  playlist
```{r}
# calm down playlist    
list="PLBBABD9C8CA13B2F5" (Works)
# R playist(44)
PLbcglKxZP5PMSKRxgVtFG2yrYhcCFgSJU

# v is list 
v <- get_playlist_items(filter = 
   c(playlist_id="PLBBABD9C8CA13B2F5"), 
                        part="snippet",
                   max_results = 2000)
eval(list)
t <- as_tibble(v)
t %>% select(snippet.title, snippet.publishedAt) %>% knitr::kable()
```

#### list all playlist titles
```{r}

# max playlists =50 
z <- tibble(get_playlists(
    filter=c(channel_id="UClB5qWyXejlAwwkDAzJis-Q"),
    part="snippet,contentDetails",
    max_results = 50,
    simplify=TRUE)
)


# remove layers 
l <- z[[1]][[5]]

# l holds all playlists 
length(l)

# number of snips is number of playlist s
snips <- map(l, "snippet")

map_chr(snips, "title")
```


