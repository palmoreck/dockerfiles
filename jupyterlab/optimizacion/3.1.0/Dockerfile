FROM ubuntu:20.04

ENV TIMEZONE America/Mexico_City
ENV JUPYTERLAB_VERSION 3.1.0
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV DEB_BUILD_DEPS="build-essential python3-dev python3-pip python3-setuptools software-properties-common libgit2-dev dirmngr libgmp3-dev libmpfr-dev"
ENV DEB_PACKAGES="sudo nano less git curl wget htop"
ENV PIP_PACKAGES="numpy scipy matplotlib pandas seaborn sympy cvxpy pytest"

ENV R_KEY="E298A3A825C0D65DFD57CBB651716619E084DAB9"
ENV R_DEB_BUILD_DEPS="focal-cran40 r-base libssl-dev libxml2-dev libcurl4-openssl-dev"
ENV R_SITE_LIBRARY="/usr/local/lib/R/site-library"
ENV R_PACKAGES="var=\"repr IRdisplay evaluate crayon pbdZMQ devtools uuid digest CVXR tidyverse\""

RUN apt-get update && export $DEBIAN_FRONTEND && \
    echo $TIMEZONE > /etc/timezone && apt-get install -y tzdata

RUN apt-get update && apt-get install -y $DEB_BUILD_DEPS $DEB_PACKAGES && pip3 install --upgrade pip

# Install nodejs deps
RUN curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash - && apt-get install -y nodejs

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $R_KEY && \
    add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/" && \
    apt-get update && \
    apt-get install -yt $R_DEB_BUILD_DEPS

RUN groupadd myuser
RUN useradd myuser -g myuser -m -s /bin/bash
RUN echo 'myuser ALL=(ALL:ALL) NOPASSWD:ALL' | (EDITOR='tee -a' visudo)
RUN echo 'myuser:qwerty' | chpasswd
RUN pip3 install jupyter jupyterlab==$JUPYTERLAB_VERSION
USER myuser

RUN jupyter notebook --generate-config && sed -i "s/# c.NotebookApp.password = .*/c.NotebookApp.password = u'sha1:115e429a919f:21911277af52f3e7a8b59380804140d9ef3e2380'/" ~/.jupyter/jupyter_notebook_config.py

RUN pip3 install $PIP_PACKAGES

#c kernel
RUN sudo chmod gou+wrx -R /usr/local/share/jupyter/kernels/
RUN python_version=$(ls ~/.local/lib/|grep python) && pip3 install --user git+https://github.com/brendan-rius/jupyter-c-kernel.git && python3 ~/.local/lib/$python_version/site-packages/jupyter_c_kernel/install_c_kernel --prefix=/usr/local/

#r kernel and packages
RUN echo $R_PACKAGES >  ~/.Renviron && \
    sudo chmod gou+w $R_SITE_LIBRARY && \
    R -e 'install.packages(strsplit(system("echo $var", intern=TRUE)," ")[[1]], lib="/usr/local/lib/R/site-library/")' && \
    R -e 'devtools::install_github("IRkernel/IRkernel")' && \
    sudo R -e 'IRkernel::installspec(user=FALSE)'

#julia kernel
RUN julia_version=1.6 && julia_version_2=1.6.2 && \
    sudo mkdir /usr/local/julia-$julia_version_2 && cd ~ && \
    wget https://julialang-s3.julialang.org/bin/linux/x64/$julia_version/julia-$julia_version_2-linux-x86_64.tar.gz && \
    tar zxvf julia-$julia_version_2-linux-x86_64.tar.gz && \
    sudo cp -r julia-$julia_version_2/* /usr/local/julia-$julia_version_2/ && \
    /usr/local/julia-$julia_version_2/bin/julia -e 'using Pkg;Pkg.add("IJulia")' && \
    echo 'export PATH=/usr/local/julia-$julia-version/bin/:$PATH' >> $HOME/.bashrc
#last line could also be: using IJulia;installkernel("Julia (4 threads)", env=Dict("JULIA_NUM_THREADS"=>"4"))

RUN sudo chmod gou+wx -R ~/.local

ENTRYPOINT ["/usr/local/bin/jupyter", "lab", "--ip=0.0.0.0", "--no-browser"]
