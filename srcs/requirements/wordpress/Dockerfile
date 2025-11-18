FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	apt-utils \
	php7.4-fpm \
    php7.4-mysql \
    php7.4-curl \
    php7.4-gd \
    php7.4-intl \
    php7.4-mbstring \
    php7.4-soap \
    php7.4-xml \
    php7.4-xmlrpc \
    php7.4-zip \
    wget \
    curl \
    mariadb-client && \
	rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY tools/wpconfig.sh /usr/local/bin/wpconfig.sh

RUN chmod +x /usr/local/bin/wpconfig.sh

RUN mkdir -p /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    mkdir -p /run/php && \
    chown -R www-data:www-data /run/php

EXPOSE 9000

CMD ["/usr/local/bin/wpconfig.sh"]