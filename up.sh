#!/bin/bash

mkdir -p docker/.volume/postgres docker/.volume/localstack
cp .dev.env .env

MY_UID=$(id -u) MY_GID="$(id -g)" docker compose -p miwil -f docker/docker-compose.yml build
MY_UID=$(id -u) MY_GID="$(id -g)" docker compose -p miwil -f docker/docker-compose.yml up -d

while [[ "$(pg_isready -d postgres -h localhost)" != *"accepting connections"* ]]; do sleep 2; done

npm run build

python manage.py makemigrations
python manage.py migrate

python manage.py collectstatic --no-input
DJANGO_SUPERUSER_PASSWORD=admin python manage.py createsuperuser --no-input --username admin --email none@fake.dev

python manage.py runserver

# MY_UID=$(id -u) MY_GID="$(id -g)" docker compose -p miwil -f docker/docker-compose.yml down
# sudo rm -rf docker/.volume
