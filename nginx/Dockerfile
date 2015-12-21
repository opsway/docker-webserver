FROM nginx

RUN rm /etc/nginx/conf.d/default.conf

ADD ./default.conf /etc/nginx/conf.d/

COPY docker-entrypoint.sh /entrypoint.sh

VOLUME ["/var/www"]

VOLUME ["/etc/nginx/sites-enabled"]

RUN ["chmod", "a+x", "/entrypoint.sh"]

ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]

WORKDIR /var/www