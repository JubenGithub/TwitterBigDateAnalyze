select created_at, `user`.screen_name, text,retweeted_status.favorite_count from tweetsjson
where 
unix_timestamp(concat(substr(created_at, 5, 6), substr(created_at, -5)), "MMM dd yyyy") >= unix_timestamp("2018-04-30", "yyyy-MM-dd")
and unix_timestamp(concat(substr(created_at, 5, 6), substr(created_at, -5)), "MMM dd yyyy") <= unix_timestamp("2018-05-03", "yyyy-MM-dd")
 ORDER BY favorite_count DESC limit 10
;
