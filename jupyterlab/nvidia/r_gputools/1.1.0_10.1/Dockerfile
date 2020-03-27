FROM nvidia/cuda:10.1-devel-ubuntu18.04

ENV JUPYTERLAB_VERSION 1.1.0
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && echo "America/Mexico_City" > /etc/timezone && apt-get install -y tzdata

RUN apt-get update && apt-get install -y \
            sudo \
            nano \
            less \
            git \
            wget \
            curl \
            python3-dev \
            python3-pip \
            python3-setuptools \
            nodejs \
            software-properties-common && pip3 install --upgrade pip

#RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && \
RUN gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && \
    gpg -a --export E298A3A825C0D65DFD57CBB651716619E084DAB9 | sudo apt-key add - && \
    add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/' && \
    apt-get update && \
    apt-get install -y r-base libssl-dev libxml2-dev libcurl4-openssl-dev

RUN groupadd miuser
RUN useradd miuser -g miuser -m -s /bin/bash
RUN echo 'miuser ALL=(ALL:ALL) NOPASSWD:ALL' | (EDITOR='tee -a' visudo)
RUN echo 'miuser:qwerty' | chpasswd
RUN pip3.6 install jupyter jupyterlab==$JUPYTERLAB_VERSION --upgrade
USER miuser

RUN jupyter notebook --generate-config && sed -i "s/#c.NotebookApp.password = .*/c.NotebookApp.password = u'sha1:115e429a919f:21911277af52f3e7a8b59380804140d9ef3e2380'/" /home/miuser/.jupyter/jupyter_notebook_config.py

RUN sudo chmod gou+w /usr/local/lib/R/site-library && \
    sudo ln -s /usr/local/cuda-10.1/compat/libcuda.so.418.87.01 /usr/lib/x86_64-linux-gnu/libcuda.so.1 && \
    sudo ln -s /usr/local/cuda-10.1/compat/libnvidia-fatbinaryloader.so.418.87.01 /usr/lib/x86_64-linux-gnu/libnvidia-fatbinaryloader.so.418.87.01 && \
    cd /home/miuser && wget https://cran.r-project.org/src/contrib/Archive/gputools/gputools_1.1.tar.gz && \
    R CMD INSTALL --configure-args="--with-r-include=/usr/share/R/include" gputools_1.1.tar.gz && \
    sudo R -e 'install.packages(c("repr", "IRdisplay", "evaluate", "crayon", "pbdZMQ", "devtools", "uuid", "digest"), lib="/usr/local/lib/R/site-library/")' && \
    R -e 'devtools::install_github("IRkernel/IRkernel")' && \
    sudo R -e 'IRkernel::installspec(user=FALSE)'
RUN sudo rm -r /usr/lib/x86_64-linux-gnu/libnvidia-fatbinaryloader.so.418.87.01
RUN sudo chmod gou+wx -R /home/miuser/.local

ENTRYPOINT ["/usr/local/bin/jupyter", "lab", "--ip=0.0.0.0", "--no-browser"]
