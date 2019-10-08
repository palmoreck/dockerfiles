FROM ubuntu:bionic

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
ARG POSTGRESQL_VERSION=$POSTGRESQL_VERSION
COPY $POSTGRESQL_VERSION/setup.sh /home/postgres/setup.sh
RUN chmod gou+x /home/postgres/setup.sh
USER postgres
# Add VOLUMEs to allow backup of config, logs and databases
VOLUME ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]
ENTRYPOINT ["/home/postgres/setup.sh"]
