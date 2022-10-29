#!/bin/bash

PWD_STORE=$(pwd)

function RUN {
    echo "$: $1"
    $1 2> /dev/null > /dev/null
}

# show consent "are you sure?"
echo "start?! (y/n)?"
read -p "> " CONFIRM

if [ "$CONFIRM" != "y" ]; then
    echo "next time :) ..."
    exit 1
fi

echo "run place variables ... (y/n)?"
read -p "> " CONFIRM
if [ "$CONFIRM" != "n" ]; then
    echo "+ run place variables ..."
    cd $PWD_STORE && $PWD_STORE/place-variables.sh
fi


echo "run treafik ... (y/n)?"
read -p "> " CONFIRM
if [ "$CONFIRM" != "n" ]; then
    echo "+ run treafik ..."
    cd $PWD_STORE/traefik && ./run.sh
fi


echo "start db ... (y/n)?"
read -p "> " CONFIRM
if [ "$CONFIRM" != "n" ]; then
    echo "+ start db ..."
    cd $PWD_STORE/chat && docker compose up -d postgres
fi

echo "run get element web ... (y/n)?"
read -p "> " CONFIRM
if [ "$CONFIRM" != "n" ]; then
    echo "+ run get element web ..."
    cd $PWD_STORE && $PWD_STORE/get-element-web.sh
fi


# read -p "> server name again : " SERVER_NAME
source $PWD_STORE/chat/.env
source $PWD_STORE/.env

echo "create key for synapse ... (y/n)?"
read -p "> " CONFIRM
if [ "$CONFIRM" != "n" ]; then
    echo "+ run create key for synapse ..."
    cd $PWD_STORE
    docker run -it --rm \
        -v $PWD_STORE/chat/synapse:/data \
        -e SYNAPSE_SERVER_NAME=$DOMAIN \
        -e SYNAPSE_REPORT_STATS=yes \
        -e UID=1000 \
        -e GID=1000 \
        matrixdotorg/synapse:$SYNAPSE_VERSION generate

fi

chown -R 1000:1000 $PWD_STORE/chat/synapse


echo "create synapse user in db ... (y/n)?"
read -p "> " CONFIRM
if [ "$CONFIRM" != "n" ]; then
    echo "+ run create synapse user in db ..."
    docker exec -it chat_postgres psql -U postgres -c "CREATE ROLE synapse;"
    docker exec -it chat_postgres psql -U postgres -c "ALTER ROLE synapse WITH PASSWORD '$POSTGRES_SYNAPSE_PASSWORD';"
    docker exec -it chat_postgres psql -U postgres -c "ALTER ROLE synapse WITH LOGIN;"
    docker exec -it chat_postgres psql -U postgres -c "CREATE DATABASE synapse ENCODING 'UTF8' LC_COLLATE='C' LC_CTYPE='C' template=template0 OWNER synapse;"
    docker exec -it chat_postgres psql -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE synapse TO synapse;"
fi



echo "run main web server ... (y/n)?"
read -p "> " CONFIRM
if [ "$CONFIRM" != "n" ]; then
    echo "+ run main webserver ..."
    cd $PWD_STORE/main && docker compose up -d
fi


echo "run chat ... (y/n)?"
read -p "> " CONFIRM
if [ "$CONFIRM" != "n" ]; then
    echo "+ run chat ..."
    cd $PWD_STORE/chat && docker compose up -d
fi



echo "ENJOY!"


 