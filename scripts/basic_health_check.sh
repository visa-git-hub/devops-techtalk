#!/bin/bash

#for i in `seq 1 10`;
#do
#  HTTP_CODE=`curl --write-out '%{http_code}' -o /dev/null -m 10 -q -s http://localhost:80`
#  if [ "$HTTP_CODE" == "200" ]; then
#    echo "Successfully pulled root page."
#    exit 0;
#  fi
#  echo "Attempt to curl endpoint returned HTTP Code $HTTP_CODE. Backing off and retrying."
#  sleep 10
#done
#echo "Server did not come up after expected time. Failing."
#exit 1

STAT=`netstat -na | grep 8080 | awk '{print $7}'`
if [ "$STAT" = "LISTEN" ]; then
    echo "DEFAULT TOMCAT PORT IS LISTENING, SO ITS OK"
elif [ "$STAT" = "" ]; then 
    echo "8080 PORT IS NOT IN USE SO TOMCAT IS NOT WORKING"
    ## only if you defined CATALINA_HOME in JAVA ENV ##
    cd $CATALINA_HOME/bin
    ./startup.sh
fi
RESULT=`netstat -na | grep 8080 | awk '{print $7}' | wc -l`
if [ "$RESULT" = 0 ]; then
    echo "TOMCAT PORT STILL NOT LISTENING"
elif [ "$RESULT" != 0 ]; then
    echo "TOMCAT PORT IS LISTENINS AND SO TOMCAT WORKING"
fi
