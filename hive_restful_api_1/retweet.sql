select created_at, `user`.screen_name, text, retweeted_status.retweet_count from tweetsjson 
order by retweet_count DESC limit 10;
