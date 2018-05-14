add jar /Users/zhiyongyang/hadoop/689-18-P2/hive-serdes-1.0-SNAPSHOT.jar;
CREATE  External TABLE 1tweets (
id BIGINT,
created_at STRING,
source STRING,
favorited BOOLEAN,
retweet_count INT,
retweeted_status STRUCT<
	text:STRING,
	`user`:STRUCT<screen_name:STRING,name:STRING>,
	retweet_count:INT,
	favorite_count:INT
>,
entities STRUCT<
	urls:ARRAY<STRUCT<expanded_url:STRING>>,
	user_mentions:ARRAY<STRUCT<screen_name:STRING,name:STRING>>,
	hashtags:ARRAY<STRUCT<text:STRING>>>,
text STRING,
`user` STRUCT<
	screen_name:STRING,
	name:STRING,
	friends_count:INT,
	followers_count:INT,
	statuses_count:INT,
	verified:BOOLEAN,
	utc_offset:INT,
	time_zone:STRING>,
	in_reply_to_screen_name STRING
) 
ROW FORMAT SERDE 'com.cloudera.hive.serde.JSONSerDe'
LOCATION '/user/flume/tweets';