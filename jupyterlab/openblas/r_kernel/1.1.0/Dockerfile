FROM ubuntu:bionic

ENV JUPYTERLAB_VERSION=1.1.0
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && echo "America/Mexico_City" > /etc/timezone && apt-get install -y tzdata

RUN apt-get update && apt-get install -y \
			build-essential \
			gfortran \
	                sudo \
                        nano \
                        less \
                        git \
                        libopenblas-dev \
                        python3-dev \
                        python3-pip \
                        python3-setuptools \
                        nodejs \
                        software-properties-common \
			linux-tools-$(uname -r) linux-tools-generic \
		        valgrind && pip3 install --upgrade pip

RUN pip3.6 install jupyter jupyterlab==$JUPYTERLAB_VERSION --upgrade
RUN groupadd miuser
RUN useradd miuser -g miuser -m -s /bin/bash
RUN echo 'miuser ALL=(ALL:ALL) NOPASSWD:ALL' | (EDITOR='tee -a' visudo)
RUN echo 'miuser:qwerty' | chpasswd

USER miuser

RUN jupyter notebook --generate-config && sed -i "s/#c.NotebookApp.password = .*/c.NotebookApp.password = u'sha1:115e429a919f:21911277af52f3e7a8b59380804140d9ef3e2380'/" /home/miuser/.jupyter/jupyter_notebook_config.py

ENV HOME /home/miuser

COPY run.sh ${HOME}

RUN sudo chmod +x ${HOME}/run.sh

ENTRYPOINT ["/home/miuser/run.sh"]
