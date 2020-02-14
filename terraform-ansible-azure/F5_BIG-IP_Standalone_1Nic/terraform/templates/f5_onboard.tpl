#!/bin/bash

# BIG-IPS ONBOARD SCRIPT

LOG_FILE=${onboard_log}

if [ ! -e $LOG_FILE ]
then
     touch $LOG_FILE
     exec &>>$LOG_FILE
else
    #if file exists, exit as only want to run once
    exit
fi

exec 1>$LOG_FILE 2>&1

# CHECK TO SEE NETWORK IS READY
CNT=0
while true
do
  STATUS=$(curl -s -k -I example.com | grep HTTP)
  if [[ $STATUS == *"200"* ]]; then
    echo "Got 200! VE is Ready!"
    break
  elif [ $CNT -le 6 ]; then
    echo "Status code: $STATUS  Not done yet..."
    CNT=$[$CNT+1]
  else
    echo "GIVE UP..."
    break
  fi
  sleep 10
done

### DOWNLOAD ONBOARDING PKGS
# Could be pre-packaged or hosted internally

DO_URL='${DO_URL}'
DO_FN=$(basename "$DO_URL")
AS3_URL='${AS3_URL}'
AS3_FN=$(basename "$AS3_URL")
TS_URL='${TS_URL}'
TS_FN=$(basename "$TS_URL")
CloudFailover_URL='${CloudFailover_URL}'
CloudFailover_FN=$(basename "$CloudFailover_URL")

mkdir -p ${libs_dir}

# echo -e "\n"$(date) "Download Declarative Onboarding Pkg"
# curl -L -o ${libs_dir}/$DO_FN $DO_URL

# echo -e "\n"$(date) "Download CloudFailover Pkg"
# curl -L -o ${libs_dir}/$CloudFailover_FN $CloudFailover_URL
# sleep 20

# echo -e "\n"$(date) "Download TS Pkg"
# curl -L -o ${libs_dir}/$AS3_FN $TS_URL

# sleep 30

# echo -e "\n"$(date) "Download AS3 Pkg"
# curl -L -o ${libs_dir}/$AS3_FN $AS3_URL
# sleep 20

echo -e "\n"$(date) "Download Declarative Onboarding Pkg"
curl -L -o ${libs_dir}/$DO_FN $DO_URL
sleep 90

echo -e "\n"$(date) "Download AS3 Pkg"
curl -L -o ${libs_dir}/$AS3_FN $AS3_URL
sleep 120

echo -e "\n"$(date) "Download CloudFailover Pkg"
curl -L -o ${libs_dir}/$CloudFailover_FN $CloudFailover_URL
sleep 60

echo -e "\n"$(date) "Download TS Pkg"
curl -L -o ${libs_dir}/$TS_FN $TS_URL
sleep 60

# Copy the RPM Pkg to the file location
cp ${libs_dir}/*.rpm /var/config/rest/downloads/

# Install Declarative Onboarding Pkg
DATA="{\"operation\":\"INSTALL\",\"packageFilePath\":\"/var/config/rest/downloads/$DO_FN\"}"
echo -e "\n"$(date) "Install DO Pkg"
restcurl -X POST "shared/iapp/package-management-tasks" -d $DATA

# Install AS3 Pkg
DATA="{\"operation\":\"INSTALL\",\"packageFilePath\":\"/var/config/rest/downloads/$AS3_FN\"}"
echo -e "\n"$(date) "Install AS3 Pkg"
restcurl -X POST "shared/iapp/package-management-tasks" -d $DATA

# Install CloudFailover Pkg
DATA="{\"operation\":\"INSTALL\",\"packageFilePath\":\"/var/config/rest/downloads/$CloudFailover_FN\"}"
echo -e "\n"$(date) "Install CloudFailover Pkg"
restcurl -X POST "shared/iapp/package-management-tasks" -d $DATA

# Install TS Pkg
DATA="{\"operation\":\"INSTALL\",\"packageFilePath\":\"/var/config/rest/downloads/$TS_FN\"}"
echo -e "\n"$(date) "Install TS Pkg"
restcurl -X POST "shared/iapp/package-management-tasks" -d $DATA