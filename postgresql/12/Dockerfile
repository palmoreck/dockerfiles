FROM ubuntu:bionic

ENV POSTGRESQL_VERSION 12
ENV RELEASE=bionic

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && echo "America/Mexico_City" > /etc/timezone && apt-get install -y tzdata

RUN apt-get update && apt-get install -y \
            sudo \
            nano \
            openssh-server \
            openssl \
	    gnupg
RUN groupadd postgres
RUN useradd postgres -g postgres -m -s /bin/bash
RUN echo 'postgres ALL=(ALL:ALL) NOPASSWD:ALL' | (EDITOR='tee -a' visudo)
RUN echo 'postgres:postgres' | chpasswd
USER postgres 

# Add VOLUMEs to allow backup of config, logs and databases
COPY setup.sh /home/postgres/setup.sh
VOLUME ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]
ENTRYPOINT ["/home/postgres/setup.sh"]
#CMD ["/usr/lib/postgresql/$POSTGRESQL_VERSION/bin/postgres", "-D", "/var/lib/postgresql/$POSTGRESQL_VERSION/main", "-c", "config_file=/etc/postgresql/$POSTGRESQL_VERSION/main/postgresql.conf"]
