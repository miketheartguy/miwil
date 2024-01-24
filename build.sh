#!/bin/bash

npm run build
python manage.py collectstatic
poetry export --format=requirements.txt -o requirements.txt --without-hashes
fly deploy
