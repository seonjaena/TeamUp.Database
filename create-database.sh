#!/bin/bash

MIN_VERSION=$1
DB_USER=$2
DB_PASSWORD=$3
if  [ -z  "$4" ] 
then
    REMOTE_HOST=
else
    REMOTE_HOST=$4
fi

# SQL 파일이 저장된 디렉터리 경로
DIRECTORY='./sql'

# 디렉터리 내의 모든 .sql 파일을 찾아 MariaDB에 실행
for sql_file in $DIRECTORY/*.sql; do

    # 파일 이름에서 버전 추출 (예: V001)
    VERSION=$(basename "$sql_file" | awk -F'_' '{print $1}')

    # 버전이 MIN_VERSION 이상인지 확인
    if [[ "$VERSION" < "$MIN_VERSION" ]]; then
        echo "Skipping $sql_file due to version check"
        continue
    fi

    cp "$sql_file" "$sql_file"_bak
    sed -i "s/DB_USER_ID_MODIFY/$DB_USER/g" "$sql_file"
    sed -i "s/DB_USER_PASSWORD_MODIFY/$DB_PASSWORD/g" "$sql_file"
    echo "Executing $sql_file"
    if [ -z "$REMOTE_HOST" ]; then
        mysql -u"$DB_USER" -p"$DB_PASSWORD" < "$sql_file"
    else
        mysql -u"$DB_USER" -p"$DB_PASSWORD" -h "$REMOTE_HOST" < "$sql_file"
    fi
    rm "$sql_file"
    mv "$sql_file"_bak "$sql_file"
done

echo "All SQL files have been executed."
