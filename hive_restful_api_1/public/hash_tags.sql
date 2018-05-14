select lower(hashtags.text), count(*) as total_count from tweetsjson LATERAL VIEW EXPLODE(entities.hashtags) t1 as hashtags
group by lower(hashtags.text) order by total_count DESC limit 10;
