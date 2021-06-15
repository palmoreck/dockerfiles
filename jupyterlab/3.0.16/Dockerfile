FROM ubuntu:20.04

ENV TIMEZONE America/Mexico_City
ENV JUPYTERLAB_VERSION 3.0.16
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV DEB_BUILD_DEPS="python3-dev python3-pip python3-setuptools software-properties-common"
ENV DEB_PACKAGES="sudo nano less git nodejs curl wget htop"

RUN apt update && export $DEBIAN_FRONTEND && \
    echo $TIMEZONE > /etc/timezone && apt install -y tzdata

RUN apt update && apt install -y $DEB_BUILD_DEPS $DEB_PACKAGES && \
    pip3 install --upgrade pip
    
    
RUN groupadd myuser
RUN useradd myuser -g myuser -m -s /bin/bash
RUN echo 'myuser ALL=(ALL:ALL) NOPASSWD:ALL' | (EDITOR='tee -a' visudo)
RUN echo 'myuser:qwerty' | chpasswd
RUN pip3 install jupyter jupyterlab==$JUPYTERLAB_VERSION
USER myuser

RUN jupyter notebook --generate-config && \
    sed -i "s/# c.NotebookApp.password = .*/c.NotebookApp.password = u'sha1:115e429a919f:21911277af52f3e7a8b59380804140d9ef3e2380'/" ~/.jupyter/jupyter_notebook_config.py && \
    sed -i "s/# c.NotebookApp.certfile = .*/c.NotebookApp.certfile = u'\/shared_volume\/certs\/cert.pem'/" ~/.jupyter/jupyter_notebook_config.py && \
    sed -i "s/# c.NotebookApp.keyfile = .*/c.NotebookApp.keyfile = u'\/shared_volume\/certs\/privkey.key'/" ~/.jupyter/jupyter_notebook_config.py

VOLUME ["/shared_volume"]

ENTRYPOINT ["/usr/local/bin/jupyter", "lab", "--ip=0.0.0.0", "--no-browser"]
