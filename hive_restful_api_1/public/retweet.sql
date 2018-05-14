select created_at, `user`.screen_name, text, retweeted_status.retweet_count from tweetsjson 
where
unix_timestamp(concat(substr(created_at, 5, 6), substr(created_at, -5)), "MMM dd yyyy") <= unix_timestamp("2018-04-27", "yyyy-MM-dd")
order by retweet_count DESC limit 100;
