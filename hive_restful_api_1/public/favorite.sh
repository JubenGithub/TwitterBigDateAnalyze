#!/bin/bash
sqlfile=favorite.sql
hive=/Users/jeanhsu/Documents/apache-hive-1.2.2-bin/bin/hive
out=/Users/jeanhsu/Documents/hive_restful_api_1/public/tmp/out
out2=/Users/jeanhsu/Documents/hive_restful_api_1/public/tmp/out2
echo "select created_at, \`user\`.screen_name, text,retweeted_status.favorite_count from tweetsjson" > $sqlfile
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

echo " ORDER BY favorite_count DESC limit $1" >>$sqlfile
echo ";" >>$sqlfile
$hive -f $sqlfile > $out
cat $out | grep -v "SLF4J:" >> $out2
rm $out

