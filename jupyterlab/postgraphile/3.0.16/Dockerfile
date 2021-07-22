#jedi was downgraded to jedi==0.17.2, see: https://github.com/jupyter/notebook/issues/2435
FROM ubuntu:bionic
ENV TIMEZONE America/Mexico_City
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV JUPYTERLAB_VERSION 3.0.16
ENV DEBIAN_FRONTEND noninteractive
ENV DEB_BUILD_DEPS="python3-dev python3-pip python3-setuptools"
ENV DEB_PACKAGES="sudo nano less git wget curl python3-gdal postgresql-client"
ENV PIP_PACKAGES_COMMON="numpy scipy matplotlib seaborn pandas psycopg2-binary django pandas geopandas rasterio fiona jedi==0.17.2"

RUN apt-get update && export $DEBIAN_FRONTEND && \
    echo $TIMEZONE > /etc/timezone && apt-get install -y tzdata

RUN apt-get update && apt-get install -y $DEB_BUILD_DEPS $DEB_PACKAGES && pip3 install --upgrade pip  

RUN groupadd myuser
RUN useradd myuser -g myuser -m -s /bin/bash
RUN echo 'myuser ALL=(ALL:ALL) NOPASSWD:ALL' | (EDITOR='tee -a' visudo)
RUN echo 'myuser:qwerty' | chpasswd

RUN pip install jupyter jupyterlab==$JUPYTERLAB_VERSION

USER myuser

#instal nvm that will install node

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

#RUN export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

RUN echo 'export NVM_DIR="$HOME/.nvm"'                                       >> "$HOME/.bashrc"
RUN echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm' >> "$HOME/.bashrc"
RUN echo '[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion" # This loads nvm bash_completion' >> "$HOME/.bashrc"


#RUN nvm install 16.4.1 && npm install -g npm@7.19.1

RUN bash -c 'source $HOME/.nvm/nvm.sh && nvm install --lts'

#install yarn

#RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && sudo apt update && sudo apt install -y --no-install-recommends yarn

RUN bash -c 'source $HOME/.nvm/nvm.sh && npm install --global yarn'

#install postgraphile, postgis
RUN bash -c 'source $HOME/.nvm/nvm.sh && cd ~ && yarn add postgraphile @graphile/postgis postgraphile-plugin-connection-filter postgraphile-plugin-connection-filter-postgis'

#RUN npm install postgraphile @graphile/postgis postgraphile-plugin-connection-filter postgraphile-plugin-connection-filter-postgis

#next password is dummy

RUN jupyter notebook --generate-config && \
    sed -i "s/#c.NotebookApp.password = .*/c.NotebookApp.password = u'sha1:115e429a919f:21911277af52f3e7a8b59380804140d9ef3e2380'/" ~/.jupyter/jupyter_notebook_config.py
        
RUN pip install $PIP_PACKAGES_COMMON --upgrade

ENTRYPOINT ["/usr/local/bin/jupyter", "lab", "--ip=0.0.0.0", "--no-browser"]
