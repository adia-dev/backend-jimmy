#!/usr/bin/env sh
until python manage.py migrate; do
echo "Migrations failed, retrying in 3 seconds..."
sleep 3
done
python manage.py loaddata ./fixtures/articles.json
python -m gunicorn --bind=0.0.0.0:8000 backend.wsgi