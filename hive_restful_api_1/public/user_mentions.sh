#!/bin/bash
sqlfile=user_mentions.sql;
hive=/Users/jeanhsu/Documents/apache-hive-1.2.2-bin/bin/hive
out=/Users/jeanhsu/Documents/hive_restful_api_1/public/tmp/out
out2=/Users/jeanhsu/Documents/hive_restful_api_1/public/tmp/out2
echo "select user_mentions.screen_name, count(*) as total_count from tweetsjson LATERAL VIEW EXPLODE(entities.user_mentions) t1 as user_mentions" > $sqlfile
if [ "$2" != "none" ]
then
	echo "where " >> $sqlfile
	echo "unix_timestamp(concat(substr(created_at, 5, 6), substr(created_at, -5)), \"MMM dd yyyy\") >= unix_timestamp(\"$2\", \"yyyy-MM-dd\")" >> $sqlfile
	if [ "$3" != "none" ] 
	then
		echo  "and unix_timestamp(concat(substr(created_at, 5, 6), substr(created_at, -5)), \"MMM dd yyyy\") <= unix_timestamp(\"$3\", \"yyyy-MM-dd\")" >>$sqlfile
	fi
else
	if [ "$3" != "none" ] 
	then
		echo "where" >> $sqlfile
		echo  "unix_timestamp(concat(substr(created_at, 5, 6), substr(created_at, -5)), \"MMM dd yyyy\") <= unix_timestamp(\"$3\", \"yyyy-MM-dd\")" >>$sqlfile
	fi
fi
echo "group by user_mentions.screen_name order by total_count DESC limit $1;" >> $sqlfile
$hive -f $sqlfile > $out
cat $out | grep -v "SLF4J:" >> $out2
rm $out
