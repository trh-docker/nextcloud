FROM quay.io/spivegin/php7:7.1

WORKDIR /opt/tlm/html
RUN apt-get update &&\
    apt-get install -y --allow-unauthenticated php7.1-zip sqlite3 php7.1-sqlite3 &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ADD files/Caddy/Caddyfile /opt/caddy/
ADD files/php/ /etc/php/7.1/fpm/pool.d/
ADD files/nextcloud/v17.0.2.zip /opt/tlm/html/nextcloud.zip
RUN unzip nextcloud.zip &&\
    rm nextcloud.zip &&\
    mkdir /opt/tlm/html/nextcloud/data &&\
    chown -R www-data:www-data .
EXPOSE 80

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/bin/entry.sh"]