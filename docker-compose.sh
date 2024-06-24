#!/bin/bash

DIRECTORY='./sql'
MAIN_TARGET_FILE='mariadb-main-mount/initdb.d/V000_INIT_DB.sql'
TEST_TARGET_FILE='mariadb-test-mount/initdb.d/V000_INIT_DB.sql'

# 디렉터리 내의 모든 .sql 파일을 찾아 MariaDB에 실행
for sql_file in $DIRECTORY/*.sql; do
    
    # 파일 이름에서 버전 추출 (예: V001)
    VERSION=$(basename "$sql_file" | awk -F'_' '{print $1}')

    if [[ "$VERSION" = "V000" ]]; then
        echo "Skipping $sql_file"
        continue
    fi
    
    cat "$sql_file" >> "$MAIN_TARGET_FILE"
    cat "$sql_file" >> "$TEST_TARGET_FILE"
done

docker compose --env-file ./db.env up -d