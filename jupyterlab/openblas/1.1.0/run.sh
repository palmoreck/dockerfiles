#!/bin/bash
USER=miuser
HOME=/home/${USER}
sudo apt-get update && sudo apt-get install -y libopenblas-dev
cd ${HOME} && pip3 install --user cython==0.29.15 pybind11==2.4.3 pytest==5.3.5 && \
	      pip3 install --user numpy==1.18.1 --no-binary numpy && \
	      pip3 install scipy==1.4.1 --user --no-binary scipy

cd / && /usr/local/bin/jupyter lab --ip=0.0.0.0 --no-browser
