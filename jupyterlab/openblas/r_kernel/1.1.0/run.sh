#!/bin/bash
USER=miuser
sudo apt-get update && sudo apt-get install -y libopenblas-dev
sudo apt-get update && \
     sudo apt-get install -y r-base libssl-dev libxml2-dev libcurl4-openssl-dev
sudo chmod gou+w /usr/local/lib/R/site-library && \
    sudo R -e 'install.packages(c("repr", "IRdisplay", "evaluate", "crayon", "pbdZMQ", "devtools", "uuid", "digest"), lib="/usr/local/lib/R/site-library/")' && \
    R -e 'devtools::install_github("IRkernel/IRkernel")' && \
    sudo R -e 'IRkernel::installspec(user=FALSE)'
sudo chmod gou+wx -R /home/miuser/.local
cd / && /usr/local/bin/jupyter lab --ip=0.0.0.0 --no-browser
