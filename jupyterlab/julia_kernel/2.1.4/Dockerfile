FROM julia:1.5-buster

ENV TIMEZONE America/Mexico_City
ENV JUPYTERLAB_VERSION 2.1.4
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV DEB_BUILD_DEPS="sudo nano less git python3-dev python3-pip python3-setuptools nodejs curl wget software-properties-common"
ENV DEB_PACKAGES=""
ENV PIP_PACKAGES="numpy scipy matplotlib pandas seaborn plotly"

RUN apt-get update && export $DEBIAN_FRONTEND && \
    echo $TIMEZONE > /etc/timezone && apt-get install -y tzdata

RUN apt-get update && apt-get install -y $DEB_BUILD_DEPS $DEB_PACKAGES && pip3 install --upgrade pip


RUN groupadd miuser
RUN useradd miuser -g miuser -m -s /bin/bash
RUN echo 'miuser ALL=(ALL:ALL) NOPASSWD:ALL' | (EDITOR='tee -a' visudo)
RUN echo 'miuser:qwerty' | chpasswd
RUN pip install jupyter jupyterlab==$JUPYTERLAB_VERSION --upgrade
USER miuser

RUN jupyter notebook --generate-config && sed -i "s/#c.NotebookApp.password = .*/c.NotebookApp.password = u'sha1:115e429a919f:21911277af52f3e7a8b59380804140d9ef3e2380'/" /home/miuser/.jupyter/jupyter_notebook_config.py

RUN pip install $PIP_PACKAGES

RUN /usr/local/julia/bin/julia -e 'using Pkg;Pkg.add("IJulia")' && \
    /usr/local/julia/bin/julia -e 'using IJulia;installkernel("Julia nodeps", "--depwarn=no")' #could also be: installkernel("Julia (4 threads)", env=Dict("JULIA_NUM_THREADS"=>"4"))

ENTRYPOINT ["/usr/local/bin/jupyter", "lab", "--ip=0.0.0.0", "--no-browser"]
