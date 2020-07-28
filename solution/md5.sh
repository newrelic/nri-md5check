#!/bin/sh

STORED_MD5="md5.txt"
JSON=`cat md5-template.json`

#validate file to check exists
if [ ! -f $FILE_TO_CHECK ]
then
  echo "ERROR: $FILE_TO_CHECK not found/does not exist!"
  exit 1
fi

#check if file is blank (still run md5sum command to populate it the first time)
if [ ! -s $STORED_MD5 ]
then
  md5sum $FILE_TO_CHECK | cut -d " " -f1 > $STORED_MD5
else
  existing_md5=`cat $STORED_MD5` #read current

  CURRENT_MD5=`md5sum $FILE_TO_CHECK | cut -d " " -f1` #get current md5 to compare with stored md5

  if [ "$existing_md5" = "$CURRENT_MD5" ]
  then
    FILE_CHANGED="false"
  else
    FILE_CHANGED="true"
    echo $CURRENT_MD5 > $STORED_MD5 #replace current md5 with new one for next check
  fi
fi

#Replace values in template
JSON=`echo ${JSON} | sed -e "s@FILE_CHANGED@${FILE_CHANGED}@"`
JSON=`echo ${JSON} | sed -e "s@CURRENT_MD5@${CURRENT_MD5}@"`

#clear whitespace
JSON=`echo ${JSON} | tr -d ' \t\n\r\f'`

#print result
echo "${JSON}"
