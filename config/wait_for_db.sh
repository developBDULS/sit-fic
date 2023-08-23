#!/bin/sh
echo "encontrado!"

while ! nc -z $DB_HOST $DB_PORT; do
    sleep 0.1
done

echo "database is ok!"

python manage.py migrate
python magage.py collectstatic --noinput

exec "$@"