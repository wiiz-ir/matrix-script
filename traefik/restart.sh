#!/bin/bash

function RUN {
    echo "$: $1"
    $1 2> /dev/null > /dev/null
}

RUN "sudo truncate -s 0 $(docker inspect --format='{{.LogPath}}' traefik)"
RUN "docker restart traefik"
docker logs traefik -f