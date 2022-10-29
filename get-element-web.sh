#!/bin/bash

ELEMENT_VERSION=v1.11.11-rc.1

RUN() {
    COMMAND=$1
    
    echo "> $COMMAND"

    $COMMAND >>/dev/null 2>&1

    if (($?)); then
        echo -e "\033[1K"
        echo "-: $COMMAND"
    else
        echo -e "\033[1K"
        echo "+: $COMMAND"
    fi

}

# Get the latest version of Element Web
#check if server has wget
if [ -x "$(command -v wget)" ]; then
    RUN "wget https://github.com/vector-im/element-web/releases/download/$ELEMENT_VERSION/element-$ELEMENT_VERSION.tar.gz -O ./chat/element/archive/element-$ELEMENT_VERSION.tar.gz"
else 
    if [ -x "$(command -v curl)" ]; then
      RUN "curl -o ./chat/element/archive/element-$ELEMENT_VERSION.tar.gz  https://github.com/vector-im/element-web/releases/download/$ELEMENT_VERSION/element-$ELEMENT_VERSION.tar.gz"
    fi
fi

RUN "rm -r ./chat/element/www/*"
RUN "tar -xzf ./chat/element/archive/element-$ELEMENT_VERSION.tar.gz -C ./chat/element/www"
RUN "mv ./chat/element/www/element-$ELEMENT_VERSION*/* ./chat/element/www"
RUN "rm -r ./chat/element/www/element-$ELEMENT_VERSION*"
RUN "cp ./chat/element/config.json ./chat/element/www/config.json"