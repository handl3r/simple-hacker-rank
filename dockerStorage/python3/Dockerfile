FROM python:3
WORKDIR /app
RUN apt-get update
RUN apt-get install bc
COPY ./script.sh /usr/bin/script.sh
RUN chmod +x /usr/bin/script.sh