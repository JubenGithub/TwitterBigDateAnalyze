select user_mentions.screen_name, count(*) as total_count from tweetsjson LATERAL VIEW EXPLODE(entities.user_mentions) t1 as user_mentions
group by user_mentions.screen_name order by total_count DESC limit 10;
