FROM julia:1.5-buster

ENV TIMEZONE America/Mexico_City
ENV JUPYTERLAB_VERSION 3.0.0
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV DEB_BUILD_DEPS="build-essential python3-dev python3-pip python3-setuptools software-properties-common libgit2-dev"
ENV DEB_PACKAGES="sudo nano less time git nodejs curl wget htop"
ENV PIP_PACKAGES="numpy scipy matplotlib pandas seaborn sympy cvxpy pytest dask distributed bokeh jupyter-book networkx ortools line_profiler memory_profiler psutil guppy3 cython numba"

ENV R_KEY="E19F5F87128899B192B1A2C2AD5F960A256A04AF"
ENV R_DEB_BUILD_DEPS="buster-cran40 r-base libssl-dev libxml2-dev libcurl4-openssl-dev"
ENV R_SITE_LIBRARY="/usr/local/lib/R/site-library"
ENV R_PACKAGES="var=\"repr IRdisplay evaluate crayon pbdZMQ devtools uuid digest CVXR tidyverse tictoc microbenchmark\""

RUN apt-get update && export $DEBIAN_FRONTEND && \
    echo $TIMEZONE > /etc/timezone && apt-get install -y tzdata

RUN apt-get update && apt-get install -y $DEB_BUILD_DEPS $DEB_PACKAGES && pip3 install --upgrade pip

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $R_KEY && \
    add-apt-repository "deb https://cloud.r-project.org/bin/linux/debian buster-cran40/" && \
    apt-get update && \
    apt-get install -yt $R_DEB_BUILD_DEPS

RUN groupadd miuser
RUN useradd miuser -g miuser -m -s /bin/bash
RUN echo 'miuser ALL=(ALL:ALL) NOPASSWD:ALL' | (EDITOR='tee -a' visudo)
RUN echo 'miuser:qwerty' | chpasswd
RUN pip3 install jupyter jupyterlab==$JUPYTERLAB_VERSION --upgrade
USER miuser

RUN jupyter notebook --generate-config && sed -i "s/# c.NotebookApp.password = .*/c.NotebookApp.password = u'sha1:115e429a919f:21911277af52f3e7a8b59380804140d9ef3e2380'/" /home/miuser/.jupyter/jupyter_notebook_config.py

RUN pip3 install $PIP_PACKAGES

#c kernel
RUN sudo chmod gou+wrx -R /usr/local/share/jupyter/kernels/
RUN pip3 install --user git+https://github.com/brendan-rius/jupyter-c-kernel.git && python3 /home/miuser/.local/lib/python3.7/site-packages/jupyter_c_kernel/install_c_kernel --prefix=/usr/local/

#r kernel and packages
RUN echo $R_PACKAGES >  ~/.Renviron && \
    sudo chmod gou+w $R_SITE_LIBRARY && \
    R -e 'install.packages(strsplit(system("echo $var", intern=TRUE)," ")[[1]], lib="/usr/local/lib/R/site-library/")' && \
    R -e 'devtools::install_github("IRkernel/IRkernel")' && \
    sudo R -e 'IRkernel::installspec(user=FALSE)'

#julia kernel 
#solvers used by default in cvxpy that will use JuMP and GLPK
RUN /usr/local/julia/bin/julia -e 'using Pkg;Pkg.add("IJulia")' && \
    /usr/local/julia/bin/julia -e 'using Pkg;Pkg.add(Pkg.PackageSpec(name="JuMP", rev="master"))' && \
    /usr/local/julia/bin/julia -e 'using Pkg;Pkg.add("ECOS");Pkg.add("OSQP");Pkg.add("SCS");Pkg.add("GLPK")' && \
    /usr/local/julia/bin/julia -e 'using Pkg;Pkg.add("Optim")'
#check line: IJulia;installkernel("Julia nodeps", "--depwarn=no")' #could also be: installkernel("Julia (4 threads)", env=Dict("JULIA_NUM_THREADS"=>"4"))

RUN sudo chmod gou+wx -R /home/miuser/.local

ENTRYPOINT ["/usr/local/bin/jupyter", "lab", "--ip=0.0.0.0", "--no-browser"]
