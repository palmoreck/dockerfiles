#dummy line to trigger build
FROM palmoreck/kale_certs:0.6.1
USER root

RUN pip install --quiet "git+https://github.com/ITAM-DS/analisis-numerico-computo-cientifico.git#egg=opt&subdirectory=src"

VOLUME ["/shared_volume"]

WORKDIR /

ENV NB_PREFIX myurl

ENTRYPOINT ["/usr/local/bin/jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root", "--LabApp.allow_origin='*'", "--LabApp.base_url=myurl"]
