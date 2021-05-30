#dummy line to trigger build
FROM ubuntu:20.04

ENV TIMEZONE America/Mexico_City
ENV JUPYTERLAB_VERSION 3.0.16
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV DEB_BUILD_DEPS="python3-dev python3-pip python3-setuptools software-properties-common dirmngr"
ENV DEB_PACKAGES="sudo nano less git nodejs curl wget htop"
ENV PIP_PACKAGES="numpy scipy matplotlib pandas seaborn plotly sympy"

ENV R_KEY="E298A3A825C0D65DFD57CBB651716619E084DAB9"
ENV R_DEB_BUILD_DEPS="r-base libxml2-dev libcurl4-openssl-dev"
ENV R_SITE_LIBRARY="/usr/local/lib/R/site-library"
ENV R_PACKAGES="\"repr IRdisplay evaluate crayon pbdZMQ devtools uuid digest prob tidyverse\""

RUN apt update && export $DEBIAN_FRONTEND && \
    echo $TIMEZONE > /etc/timezone && apt install -y tzdata

RUN apt update && apt install -y $DEB_BUILD_DEPS $DEB_PACKAGES && \
    pip3 install --upgrade pip

#R installation
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $R_KEY && \
    add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/" && \
    apt update && \
    apt install -y --no-install-recommends $R_DEB_BUILD_DEPS

RUN groupadd propeuser
RUN useradd propeuser -g propeuser -m -s /bin/bash
RUN echo 'propeuser ALL=(ALL:ALL) NOPASSWD:ALL' | (EDITOR='tee -a' visudo)
RUN echo 'propeuser:qwerty' | chpasswd
RUN pip3 install jupyter jupyterlab==$JUPYTERLAB_VERSION --upgrade
USER propeuser

RUN jupyter notebook --generate-config && sed -i "s/#c.NotebookApp.password = .*/c.NotebookApp.password = u'sha1:115e429a919f:21911277af52f3e7a8b59380804140d9ef3e2380'/" ~/.jupyter/jupyter_notebook_config.py

RUN pip3 install $PIP_PACKAGES

RUN echo $R_PACKAGES >  ~/.Renviron && \
    sudo chmod gou+w $R_SITE_LIBRARY && \
    R -e 'install.packages(strsplit(system("echo $var", intern=TRUE)," ")[[1]], lib="/usr/local/lib/R/site-library/")' && \
    R -e 'devtools::install_github("IRkernel/IRkernel")' && \
    sudo R -e 'IRkernel::installspec(user=FALSE)'

RUN sudo chmod gou+wx -R ~/.local

ENTRYPOINT ["/usr/local/bin/jupyter", "lab", "--ip=0.0.0.0", "--no-browser"]




