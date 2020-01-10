FROM quay.io/spivegin/php7:7.1

ADD files/Caddy/Caddyfile /opt/caddy/
ADD files/php/ /etc/php/7.0/fpm/pool.d/

WORKDIR /opt/tlm/html
ADD https://download.nextcloud.com/server/releases/nextcloud-17.0.2.zip /opt/tlm/html/v17.0.2.zip
RUN unzip v17.0.2.zip &&\ 
    chown -R www-data:www-data .

EXPOSE 80

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/bin/entry.sh"]