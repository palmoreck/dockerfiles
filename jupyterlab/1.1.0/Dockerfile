FROM ubuntu:bionic
USER root
ENV TIMEZONE America/Mexico_City
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND noninteractive 
ENV DEB_BUILD_DEPS="python3-dev python3-pip python3-setuptools"
ENV DEB_PACKAGES="sudo nano less git wget curl"
ENV PIP_PACKAGES_COMMON="numpy scipy pandas matplotlib seaborn"
ENV PIP_PACKAGES_KALE="kubeflow-kale==0.6.1"

RUN apt-get update && export $DEBIAN_FRONTEND && \
    echo $TIMEZONE > /etc/timezone && apt-get install -y tzdata

RUN apt-get update && apt-get install -y $DEB_PACKAGES $DEB_BUILD_DEPS && pip3 install --upgrade pip  

RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - && apt-get install -y nodejs

RUN pip3 install jupyter "jupyterlab>=2.0.0,<3.0.0"

RUN jupyter notebook --generate-config && \
    sed -i "s/# c.NotebookApp.password = .*/c.NotebookApp.password = u'sha1:94ab56ddee72:2b6e7efa5e04a4cd2bf8f63adb74ec1f3610e6f5'/" ~/.jupyter/jupyter_notebook_config.py
        
#RUN pip3 install $PIP_PACKAGES_COMMON 
RUN pip install $PIP_PACKAGES_KALE
RUN jupyter labextension install kubeflow-kale-labextension@0.6.1

VOLUME ["/shared_volume"]

WORKDIR /


ENTRYPOINT ["/usr/local/bin/jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root"]
