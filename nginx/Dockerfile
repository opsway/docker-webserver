FROM ilari/alpine-nginx-pagespeed:latest

RUN apk add --update --no-cache bash

RUN rm -f /etc/nginx/conf.d/default.conf

ADD ./default.conf /etc/nginx/conf.d/

COPY docker-entrypoint.sh /entrypoint.sh

RUN ["chmod", "a+x", "/entrypoint.sh"]

ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]

WORKDIR /app