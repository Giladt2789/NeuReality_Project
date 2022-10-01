FROM python:3.8.10-alpine3.13
WORKDIR /App
ENV SHELL=/bin/bash
RUN pip install --upgrade pip
COPY . /App
RUN pip3 install -r requirements
EXPOSE 8182
CMD gunicorn --bind 0.0.0.0:8182 wsgi:app