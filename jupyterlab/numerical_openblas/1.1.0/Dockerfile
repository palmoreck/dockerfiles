ARG JUPYTERLAB_VERSION=$JUPYTERLAB_VERSION
ARG REPO_URL_BASE=$REPO_URL_BASE

FROM $REPO_URL_BASE:$JUPYTERLAB_VERSION

ENV JUPYTERLAB_VERSION=1.1.0
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

USER root
RUN apt-get update && apt-get install -y \
			build-essential \
			gfortran \
	                nano \
            		less \
            		git \
		        htop \
            		libopenblas-dev \
            		python3-dev \
            		python3-pip \
            		python3-setuptools \
            		nodejs \
            		software-properties-common && pip3 install --upgrade pip

RUN pip3 install jupyter jupyterlab==$JUPYTERLAB_VERSION --upgrade
USER miuser
RUN jupyter notebook --generate-config && sed -i "s/#c.NotebookApp.password = .*/c.NotebookApp.password = u'sha1:115e429a919f:21911277af52f3e7a8b59380804140d9ef3e2380'/" /home/miuser/.jupyter/jupyter_notebook_config.py

ENTRYPOINT ["/home/miuser/run.sh"]
