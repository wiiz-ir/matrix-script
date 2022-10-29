#!/bin/bash

echo "+ Enter name:"
read -p "> " NAME


echo "+ external_ip (IP):"
read -p "> " EXTERNAL_IP


echo "+ Enter domain name:"
read -p "> " DOMAIN


echo "+ Enter admin email:"
read -p "> " ADMIN_EMAIL

# generate random password for database
# generate random password without special characters


POSTGRES_PASSWORD=$(openssl rand -base64 32| tr -dc 'a-zA-Z0-9')
POSTGRES_SYNAPSE_PASSWORD=$(openssl rand -base64 32| tr -dc 'a-zA-Z0-9')
macaroon_secret_key=$(openssl rand -base64 32| tr -dc 'a-zA-Z0-9')
form_secret=$(openssl rand -base64 32| tr -dc 'a-zA-Z0-9')
registration_shared_secret=$(openssl rand -base64 32| tr -dc 'a-zA-Z0-9')
turn_shared_secret=$(openssl rand -base64 32| tr -dc 'a-zA-Z0-9')

cli_password=$(openssl rand -base64 32| tr -dc 'a-zA-Z0-9')


# give a confirmation to the user
echo "----------------------------------------"
echo "Name: $NAME"
echo "IP: $EXTERNAL_IP"
echo "Domain: $DOMAIN"
echo "Admin Email: $ADMIN_EMAIL"
echo "Postgres Password: $POSTGRES_PASSWORD"
echo "Postgres SYNAPSE Password: $POSTGRES_SYNAPSE_PASSWORD"
echo "Macaroon Secret Key: $macaroon_secret_key"
echo "Form Secret: $form_secret"
echo "Registration Shared Secret: $registration_shared_secret"
echo "Turn Shared Secret: $turn_shared_secret"
echo "CLI Password: $cli_password"

echo "----------------------------------------"
echo "Is this correct? (y/n)"
read -p "> " CONFIRM

if [ "$CONFIRM" != "y" ]; then
    echo "Aborting..."
    exit 1
fi



echo "+ relacing DOMAIN"
find ./**/* -type f -not -name "place-variables.sh" -not -name "README.md" -exec sed -i "s/%%DOMAIN%%/$DOMAIN/g" {} \;
find ./**/.* -type f -not -name "place-variables.sh" -not -name "README.md" -exec sed -i "s/%%DOMAIN%%/$DOMAIN/g" {} \;

echo "+ relacing EXTERNAL_IP"
find ./**/* -type f -not -name "place-variables.sh" -not -name "README.md" -exec sed -i "s/%%external_ip%%/$EXTERNAL_IP/g" {} \;
find ./**/.* -type f -not -name "place-variables.sh" -not -name "README.md" -exec sed -i "s/%%external_ip%%/$EXTERNAL_IP/g" {} \;

echo "+ relacing NAME"
find ./**/* -type f -not -name "place-variables.sh" -not -name "README.md" -exec sed -i "s/%%NAME%%/$NAME/g" {} \;
find ./**/.* -type f -not -name "place-variables.sh" -not -name "README.md" -exec sed -i "s/%%NAME%%/$NAME/g" {} \;

echo "+ relacing ADMIN_EMAIL"
find ./**/* -type f -not -name "place-variables.sh" -not -name "README.md" -exec sed -i "s/%%ADMIN_EMAIL%%/$ADMIN_EMAIL/g" {} \;
find ./**/.* -type f -not -name "place-variables.sh" -not -name "README.md" -exec sed -i "s/%%ADMIN_EMAIL%%/$ADMIN_EMAIL/g" {} \;

echo "+ relacing POSTGRES_SYNAPSE_PASSWORD"
find ./**/* -type f -not -name "place-variables.sh" -not -name "README.md" -exec sed -i "s/%%POSTGRES_SYNAPSE_PASSWORD%%/$POSTGRES_SYNAPSE_PASSWORD/g" {} \;
find ./**/.* -type f -not -name "place-variables.sh" -not -name "README.md" -exec sed -i "s/%%POSTGRES_SYNAPSE_PASSWORD%%/$POSTGRES_SYNAPSE_PASSWORD/g" {} \;


echo "+ relacing POSTGRES_PASSWORD"
find ./**/* -type f -not -name "place-variables.sh" -not -name "README.md" -exec sed -i "s/%%POSTGRES_PASSWORD%%/$POSTGRES_PASSWORD/g" {} \;
find ./**/.* -type f -not -name "place-variables.sh" -not -name "README.md" -exec sed -i "s/%%POSTGRES_PASSWORD%%/$POSTGRES_PASSWORD/g" {} \;

echo "+ relacing macaroon_secret_key"
find ./**/* -type f -not -name "place-variables.sh" -not -name "README.md" -exec sed -i "s/%%macaroon_secret_key%%/$macaroon_secret_key/g" {} \;
find ./**/.* -type f -not -name "place-variables.sh" -not -name "README.md" -exec sed -i "s/%%macaroon_secret_key%%/$macaroon_secret_key/g" {} \;

echo "+ relacing form_secret"
find ./**/* -type f -not -name "place-variables.sh" -not -name "README.md" -exec sed -i "s/%%form_secret%%/$form_secret/g" {} \;
find ./**/.* -type f -not -name "place-variables.sh" -not -name "README.md" -exec sed -i "s/%%form_secret%%/$form_secret/g" {} \;

echo "+ relacing registration_shared_secret"
find ./**/* -type f -not -name "place-variables.sh" -not -name "README.md" -exec sed -i "s/%%registration_shared_secret%%/$registration_shared_secret/g" {} \;
find ./**/.* -type f -not -name "place-variables.sh" -not -name "README.md" -exec sed -i "s/%%registration_shared_secret%%/$registration_shared_secret/g" {} \;

echo "+ relacing turn_shared_secret"
find ./**/* -type f -not -name "place-variables.sh" -not -name "README.md" -exec sed -i "s/%%turn_shared_secret%%/$turn_shared_secret/g" {} \;
find ./**/.* -type f -not -name "place-variables.sh" -not -name "README.md" -exec sed -i "s/%%turn_shared_secret%%/$turn_shared_secret/g" {} \;

echo "+ relacing cli_password"
find ./**/* -type f -not -name "place-variables.sh" -not -name "README.md" -exec sed -i "s/%%cli_password%%/$cli_password/g" {} \;
find ./**/.* -type f -not -name "place-variables.sh" -not -name "README.md" -exec sed -i "s/%%cli_password%%/$cli_password/g" {} \;