FROM php:7.3.6-cli-alpine3.9

RUN apk add --no-cache bc
RUN apk add --update coreutils &amp;&amp; rm -rf /var/cache/apk/*

WORKDIR /home/run_user/

ADD script.sh /bin/script.sh
RUN chmod +x /bin/script.sh

ENTRYPOINT ["sh", "/bin/script.sh"]