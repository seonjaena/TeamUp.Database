#!/bin/bash

DB_USER=$1
DB_PASSWORD=$2
if  [ -z  "$3" ] 
then
    REMOTE_HOST=
else
    REMOTE_HOST=$3
fi

# SQL 파일이 저장된 디렉터리 경로
DIRECTORY='./sql'

# 디렉터리 내의 모든 .sql 파일을 찾아 MariaDB에 실행
for sql_file in $DIRECTORY/*.sql; do
    cp $sql_file "$sql_file"_bak
    sed -i "s/DB_USER_ID_MODIFY/$DB_USER/g" $sql_file
    sed -i "s/DB_USER_PASSWORD_MODIFY/$DB_PASSWORD/g" $sql_file
    echo "Executing $sql_file"
    if [ -z $REMOTE_HOST ]
    then
        mysql -u"$DB_USER" -p"$DB_PASSWORD" < $sql_file
    else
        mysql -u"$DB_USER" -p"$DB_PASSWORD" -h "$REMOTE_HOST" < $sql_file
    fi
    rm $sql_file
    mv "$sql_file"_bak $sql_file
done

echo "All SQL files have been executed."
