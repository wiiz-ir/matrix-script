# How to set up

## Requirements

### domains

- example.com
- chat.example.com
- synapse.example.com
- fed.synapse.example.com

## Software

these packages needed to be installed in your machine and working:

- docker


## STEPS

### Automate  (best)

1. bash install_run_everything.sh

### Manual



1. point domains to the server


1. run place-variable.sh to place variables in config files
    ```
    bash place-variables.sh
    ```

1. download Element client:

    ```
    bash get-element-web.sh
    ```
1. now first run traefik

    ```
    cd traefik && bash run.sh && cd ..
    ```
1. now proxy (if it is needed)

    ```
    cd proxy && docker compose up -d && cd ..
    ```

1. create key for synapse

    ```
    docker run -it --rm \
        -v $(pwd)/chat/synapse:/data \
        -e SYNAPSE_SERVER_NAME=synapse.$SERVER_NAME \
        -e SYNAPSE_REPORT_STATS=yes \
        -e UID=1000 \
        -e GID=1000 \
        matrixdotorg/synapse:latest generate
    ```
1. run database
    ```
    cd chat && docker compose up -d postgres && cd..
    ```

1. run database
    ```
    cd chat && docker compose up -d postgres && cd..
    ```
    

1. now run main this is front page of your website

    ```
    cd main && docker compose up -d && cd ..
    ```

1. now run chat server

    ```
    cd chat && docker compose up -d && cd ..
    ```

1. cheers "_"

## Variables and where you can find it.



./chat/.env                       %%DOMAIN%%
./chat/.env                       %%POSTGRES_PASSWORD%%
./chat/synapse/homeserver.yaml    %%POSTGRES_SYNAPSE_PASSWORD%%
./chat/synapse/homeserver.yaml    %%macaroon_secret_key%%
./chat/synapse/homeserver.yaml    %%form_secret%%
./chat/synapse/homeserver.yaml    %%ADMIN_EMAIL%%
./chat/synapse/homeserver.yaml    %%registration_shared_secret%%
./chat/synapse/homeserver.yaml    %%turn_shared_secret%%
./chat/coturn/turnserver.conf     %%turn_shared_secret%%
./chat/matrix/www/.well-known/matrix/client   %%DOMAIN%%
./main/docker-compose.yml         %%DOMAIN%%      
./main/traefik/traefik.yml        %%ADMIN_EMAIL%%
./chat/matrix/www/.well-known/matrix/server %%DOMAIN%%
./chat/element/www/config.json    %%DOMAIN%%
./chat/element/www/config.json    %%NAME%%
./chat/coturn/turnserver.conf     %%cli_password%%
./chat/coturn/turnserver.conf     %%external_ip%%