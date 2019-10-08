#!/bin/bash
POSTGRESQL_VERSION=10
RELEASE=bionic
sudo service ssh restart
sudo apt-get install -y \
             postgresql 
sudo /etc/init.d/postgresql start
sudo echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/$POSTGRESQL_VERSION/main/pg_hba.conf
sudo echo "local all all md5" >> /etc/postgresql/$POSTGRESQL_VERSION/main/pg_hba.conf
sudo echo "listen_addresses='*'" >> /etc/postgresql/$POSTGRESQL_VERSION/main/postgresql.conf
psql --command "ALTER USER postgres WITH PASSWORD 'postgres';"
sudo /etc/init.d/postgresql stop
sudo pg_ctlcluster $POSTGRESQL_VERSION main start --foreground
