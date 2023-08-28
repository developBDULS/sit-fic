FROM python:3.9

ENV PYTHONUNBUFFERED 1

RUN apt-get update  && \
    apt-get -y install netcat-traditional

RUN mkdir /code
WORKDIR /code
COPY Pipfile Pipfile.lock /code/
RUN pip install pipenv && pipenv install --system
COPY . /code/
COPY sitFic/adminlte/static /static/
COPY ./config/wait_for_db.sh /code/config/
RUN chmod +x /code/config/wait_for_db.sh
#RUN python /code/sitFic/manage.py collectstatic --noinput

#gunicorn config
CMD gunicorn sitFic.wsgi:application --bind 0.0.0.0:8000 --workers 4