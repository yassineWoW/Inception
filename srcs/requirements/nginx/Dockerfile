FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/sites-enabled/nginx.conf
COPY tools/setup.sh /usr/local/bin/setup.sh

RUN chmod +x /usr/local/bin/setup.sh && \
    mkdir -p /etc/nginx/ssl /var/run/nginx /var/www/html && \
    chown -R www-data:www-data /var/run/nginx /var/www/html && \
    chmod -R 755 /var/www/html

EXPOSE 443

CMD ["/usr/local/bin/setup.sh"]