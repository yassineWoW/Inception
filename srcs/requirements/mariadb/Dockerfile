FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y \
    mariadb-server \
    mariadb-client && \
    rm -rf /var/lib/apt/lists/*

COPY tools/init_db.sh /usr/local/bin/init_db.sh
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN chmod +x /usr/local/bin/init_db.sh

RUN mkdir -p /var/log/mysql && \
    chown -R mysql:mysql /var/log/mysql

RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld

RUN mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql && \
    chmod 755 /var/lib/mysql

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

EXPOSE 3306

CMD ["/usr/local/bin/init_db.sh"]