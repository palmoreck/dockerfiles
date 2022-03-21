FROM ubuntu:20.04
USER root
ENV TIMEZONE America/Mexico_City
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV DEB_BUILD_DEPS="python3-dev python3-pip python3-setuptools"
ENV DEB_PACKAGES="sudo nano less git wget curl ca-certificates"
ENV PIP_PACKAGES_COMMON="numpy scipy pandas matplotlib seaborn"
ENV PIP_PACKAGES_KALE="kubeflow-kale==0.7.0"
ENV JUPYTERLAB="jupyter-client==5.3.4 jupyterlab==2.3.2 qtconsole==5.2.1 nbconvert==5.6.1 jupyter-console==6.4.0 ipykernel==6.6.0 MarkupSafe==2.0.1"

RUN apt-get update && export $DEBIAN_FRONTEND && \
    echo $TIMEZONE > /etc/timezone && apt-get install -y tzdata

RUN apt-get update && apt-get install -y $DEB_PACKAGES $DEB_BUILD_DEPS && pip3 install --upgrade pip

RUN curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash - && apt-get install -y nodejs

RUN pip3 install $JUPYTERLAB

RUN jupyter notebook --generate-config && \
    sed -i "s/# c.NotebookApp.password = .*/c.NotebookApp.password = u'sha1:115e429a919f:21911277af52f3e7a8b59380804140d9ef3e2380'/" ~/.jupyter/jupyter_notebook_config.py && \
    sed -i "s/# c.NotebookApp.certfile = .*/c.NotebookApp.certfile = u'\/shared_volume\/certs\/cert.pem'/" ~/.jupyter/jupyter_notebook_config.py && \
    sed -i "s/# c.NotebookApp.keyfile = .*/c.NotebookApp.keyfile = u'\/shared_volume\/certs\/privkey.key'/" ~/.jupyter/jupyter_notebook_config.py


RUN pip3 install $PIP_PACKAGES_COMMON
RUN pip3 install $PIP_PACKAGES_KALE
RUN jupyter labextension install kubeflow-kale-labextension@0.7.0

VOLUME ["/shared_volume"]

WORKDIR /

ENTRYPOINT ["/usr/local/bin/jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root"]
