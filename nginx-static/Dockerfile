FROM nginx:1.10-alpine

RUN apk add --update --no-cache nodejs
RUN apk add --update --no-cache git
RUN apk add --update --no-cache python
RUN npm install -g bower
RUN npm install --global gulp-cli

RUN rm /etc/nginx/conf.d/default.conf

ADD ./default.conf /etc/nginx/conf.d/

COPY docker-entrypoint.sh /entrypoint.sh

RUN ["chmod", "a+x", "/entrypoint.sh"]

ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]

WORKDIR /app
