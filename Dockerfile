FROM quay.io/spivegin/php7:7.1

ADD files/Caddy/Caddyfile /opt/caddy/
ADD files/php/ /etc/php/7.1/fpm/pool.d/

WORKDIR /opt/tlm/html
RUN apt-get update &&\
    apt-get install -y --allow-unauthenticated php7.1-zip &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
ADD files/php/ /etc/php/${PHP_VERSION}/fpm/pool.d/
ADD files/bash/composer.sh /opt/
RUN chmod +x /opt/composer.sh && /opt/composer.sh &&\
    apt-get autoclean && apt-get autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ADD https://download.nextcloud.com/server/releases/nextcloud-17.0.2.zip /opt/tlm/html/v17.0.2.zip
RUN unzip v17.0.2.zip &&\ 
    chown -R www-data:www-data .
# RUN apt-get update &&\
#     apt-get install -y --allow-unauthenticated libapache2-mod-php7.1 \
#     php7.1-gd php7.1-json php7.1-mysql php7.1-curl \
#     php7.1-intl php7.1-mcrypt php-imagick \
#     php7.1-zip php7.1-xml php7.1-mbstring &&\
#     apt-get autoclean && apt-get autoremove &&\
#     rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

EXPOSE 80

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/opt/bin/entry.sh"]