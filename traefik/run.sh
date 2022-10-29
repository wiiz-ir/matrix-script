#!/bin/bash

function RUN {
    echo "$: $1"
    $1 2> /dev/null > /dev/null
}

RUN "docker network rm web"
RUN "docker network create web --subnet=10.50.0.0/16"
RUN "docker kill traefik"
RUN "docker rm traefik"


sleep 2

opt=""
opt="${opt} --volume /var/run/docker.sock:/var/run/docker.sock:ro"
opt="${opt} --volume $PWD/traefik.yml:/etc/traefik/traefik.yml:ro"
opt="${opt} --volume $PWD/dynamics:/etc/traefik/dynamics:ro"
opt="${opt} --volume $PWD/acme.json:/etc/traefik/acme.json"
opt="${opt} -p 0.0.0.0:80:80 -p 0.0.0.0:443:443"
# opt="${opt} --network br-iran"
opt="${opt} --network web"
opt="${opt} --name traefik"

echo "$: run traefik"
eval "docker run ${opt} -d traefik:v2.9" > /dev/null
RUN "docker network connect web traefik"
