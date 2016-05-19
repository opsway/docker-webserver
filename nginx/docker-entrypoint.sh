#!/bin/bash
set -e

if [ -n "${HTTP_AUTH}" ];
then
    echo "${HTTP_AUTH}" > /etc/nginx/htpasswd
    sed -i "s/<HTTP_AUTH>/auth_basic \"Restricted\";\n auth_basic_user_file \/etc\/nginx\/htpasswd;\n/g" /etc/nginx/conf.d/default.conf;
else
    sed -i "s/<HTTP_AUTH>//g" /etc/nginx/conf.d/default.conf;
fi

if [ -n "${LOGGLY_PORT_514_UDP_ADDR}" ];
then
    sed -i "s/<ACCESS_LOG_PLACEHOLDER>/access_log syslog:server=${LOGGLY_PORT_514_UDP_ADDR};\n/g" /etc/nginx/conf.d/default.conf;
    sed -i "s/<ERROR_LOG_PLACEHOLDER>/error_log syslog:server=${LOGGLY_PORT_514_UDP_ADDR};\n/g" /etc/nginx/conf.d/default.conf;
else
    sed -i "s/<ACCESS_LOG_PLACEHOLDER>//g" /etc/nginx/conf.d/default.conf;
    sed -i "s/<ERROR_LOG_PLACEHOLDER>//g" /etc/nginx/conf.d/default.conf;
fi

sed -i "s/<PHPFPM_HOST>/${PHPFPM_PORT_9000_TCP_ADDR:-phpfpm}/g;s/<PHPFPM_PORT>/${PHPFPM_PORT_9000_TCP_PORT:-9000}/g" /etc/nginx/conf.d/default.conf;
sed -i "s/<DOMAIN_PLACEHOLDER>/${DOMAIN:-boodmo.local}/g" /etc/nginx/conf.d/default.conf;
sed -i "s/<APPLICATION_ENV>/${APPLICATION_ENV:-dev}/g" /etc/nginx/conf.d/default.conf;
sleep 5

exec "$@"
