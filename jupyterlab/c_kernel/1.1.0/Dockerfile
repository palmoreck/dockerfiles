FROM ubuntu:bionic

ENV JUPYTERLAB_VERSION 1.1.0

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && echo "America/Mexico_City" > /etc/timezone && apt-get install -y tzdata

RUN apt-get update && apt-get install -y \
	    build-essential \
            sudo \
            nano \
            less \
            git \
            python3-dev \
            python3-pip \
            python3-setuptools \
            nodejs && pip3 install --upgrade pip

RUN groupadd miuser
RUN useradd miuser -g miuser -m -s /bin/bash
RUN echo 'miuser ALL=(ALL:ALL) NOPASSWD:ALL' | (EDITOR='tee -a' visudo)
RUN echo 'miuser:qwerty' | chpasswd
RUN pip3 install jupyter jupyterlab==$JUPYTERLAB_VERSION --upgrade
USER miuser
RUN jupyter notebook --generate-config && sed -i "s/#c.NotebookApp.password = .*/c.NotebookApp.password = u'sha1:115e429a919f:21911277af52f3e7a8b59380804140d9ef3e2380'/" /home/miuser/.jupyter/jupyter_notebook_config.py
RUN cd && git clone https://github.com/brendan-rius/jupyter-c-kernel.git && pip3 install --user jupyter-c-kernel && cd jupyter-c-kernel/jupyter_c_kernel/ && sudo python3 install_c_kernel
RUN sudo chmod gou+wx -R /home/miuser/.local
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
ENTRYPOINT ["/usr/local/bin/jupyter", "lab", "--ip=0.0.0.0", "--no-browser"]
