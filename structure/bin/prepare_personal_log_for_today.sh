#!/bin/bash 

LOG_FILE_PATTERN=`cat ~/WAREHOUSE/configs/coat/personal_log_file_position`
NEW_LOG_FILE=`eval echo "$LOG_FILE_PATTERN"`
NEW_LOG_DIR=`dirname $NEW_LOG_FILE`
mkdir -p $NEW_LOG_DIR
touch $NEW_LOG_FILE
