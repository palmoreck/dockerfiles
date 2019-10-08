#!/bin/bash
NAME_DB=mi_db
POSTGRESQL_VERSION=12
sudo service ssh restart
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - && echo "deb http://apt.postgresql.org/pub/repos/apt/ $RELEASE-pgdg main" | sudo tee  /etc/apt/sources.list.d/pgdg.list && sudo apt-get update && sudo apt-get -y install postgresql-$POSTGRESQL_VERSION

sudo /etc/init.d/postgresql start
sudo echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/$POSTGRESQL_VERSION/main/pg_hba.conf
sudo echo "local all all md5" >> /etc/postgresql/$POSTGRESQL_VERSION/main/pg_hba.conf
sudo echo "listen_addresses='*'" >> /etc/postgresql/$POSTGRESQL_VERSION/main/postgresql.conf
psql --command "ALTER USER postgres WITH PASSWORD 'postgres';"
#sudo /etc/init.d/postgresql restart
#createdb $NAME_DB
sudo /etc/init.d/postgresql stop
sudo pg_ctlcluster $POSTGRESQL_VERSION main start --foreground
