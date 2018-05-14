select created_at, `user`.screen_name, text,retweeted_status.favorite_count from tweetsjson
 ORDER BY favorite_count DESC limit 100
;
