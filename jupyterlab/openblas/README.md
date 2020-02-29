1) Build base image:

```
git clone https://github.com/palmoreck/dockerfiles.git $DIR
```

Set:

```
JUPYTERLAB_VERSION=1.1.0
REPO_URL_BASE=palmoreck/jupyterlab_openblas_base
REPO_URL=palmoreck/jupyterlab_openblas
DIR=/home/<user>/<midir>/dockerfiles/
BUILD_DIR=$DIR/jupyterlab/openblas/$JUPYTERLAB_VERSION
BUILD_DIR_BASE=$DIR/jupyterlab/openblas/base
```

```
docker build $BUILD_DIR_BASE --force-rm -t $REPO_URL_BASE:$JUPYTERLAB_VERSION
```

2) Build from base image:


```
docker build $BUILD_DIR --build-arg JUPYTERLAB_VERSION=$JUPYTERLAB_VERSION \
--build-arg REPO_URL_BASE=$REPO_URL_BASE --force-rm -t $REPO_URL:$JUPYTERLAB_VERSION
```

Run:

```
docker run -v $(pwd):/datos --name jupyterlab_openblas -p 8888:8888 -d $REPO_URL:$JUPYTERLAB_VERSION
```

or:

```
docker run --rm -v $(pwd):/datos --name jupyterlab_openblas -p 8888:8888 -d $REPO_URL:$JUPYTERLAB_VERSION
```

## jupyter lab running at localhost:8888 , password: qwerty

(not necessary) Enter to docker container with:

```
docker exec -it -u=miuser jupyterlab_openblas bash
```

Stop:

```
docker stop jupyterlab_openblas
```

Delete (if `--rm` wasn't used):


```
docker rm jupyterlab_openblas
```


