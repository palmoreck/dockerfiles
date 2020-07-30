FROM ubuntu:bionic

ENV TIMEZONE America/Mexico_City
ENV JUPYTERLAB_VERSION 2.1.4
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV DEB_BUILD_DEPS="sudo nano less build-essential git python3-dev python3-pip python3-setuptools nodejs curl wget software-properties-common"
ENV DEB_PACKAGES=""
ENV PIP_PACKAGES="numpy scipy matplotlib pandas seaborn xarray dask distributed bokeh jupyter-book"

ENV R_KEY="E298A3A825C0D65DFD57CBB651716619E084DAB9"
ENV R_DEB_BUILD_DEPS="r-base libssl-dev libxml2-dev libcurl4-openssl-dev"
ENV R_SITE_LIBRARY="/usr/local/lib/R/site-library"
ENV R_PACKAGES="var=\"repr IRdisplay evaluate crayon pbdZMQ devtools uuid digest prob tidyverse\""

RUN apt-get update && export $DEBIAN_FRONTEND && \
    echo $TIMEZONE > /etc/timezone && apt-get install -y tzdata

RUN apt-get update && apt-get install -y $DEB_BUILD_DEPS $DEB_PACKAGES && pip3 install --upgrade pip

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $R_KEY && \
    add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/" && \
    apt-get update && \
    apt-get install -y $R_DEB_BUILD_DEPS

RUN groupadd miuser
RUN useradd miuser -g miuser -m -s /bin/bash
RUN echo 'miuser ALL=(ALL:ALL) NOPASSWD:ALL' | (EDITOR='tee -a' visudo)
RUN echo 'miuser:qwerty' | chpasswd
RUN pip3 install jupyter jupyterlab==$JUPYTERLAB_VERSION --upgrade
USER miuser

RUN jupyter notebook --generate-config && sed -i "s/#c.NotebookApp.password = .*/c.NotebookApp.password = u'sha1:115e429a919f:21911277af52f3e7a8b59380804140d9ef3e2380'/" /home/miuser/.jupyter/jupyter_notebook_config.py

RUN pip3 install $PIP_PACKAGES

#c kernel
RUN sudo chmod gou+wrx -R /usr/local/share/jupyter/kernels/
RUN pip3 install --user git+https://github.com/brendan-rius/jupyter-c-kernel.git && python3 /home/miuser/.local/lib/python3.6/site-packages/jupyter_c_kernel/install_c_kernel --prefix=/usr/local/

#r kernel and tidyverse
RUN echo $R_PACKAGES >  ~/.Renviron && \
    sudo chmod gou+w $R_SITE_LIBRARY && \
    sudo R -e 'install.packages(strsplit(system("echo $var", intern=TRUE)," ")[[1]], lib="/usr/local/lib/R/site-library/")' && \
    R -e 'devtools::install_github("IRkernel/IRkernel")' && \
    sudo R -e 'IRkernel::installspec(user=FALSE)'

RUN sudo chmod gou+wx -R /home/miuser/.local

ENTRYPOINT ["/usr/local/bin/jupyter", "lab", "--ip=0.0.0.0", "--no-browser"]
