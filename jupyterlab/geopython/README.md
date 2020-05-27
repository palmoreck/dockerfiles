Set:

```
JUPYTERLAB_VERSION=1.1.0
REPO_URL=palmoreck/jupyterlab
DIR=/home/<user>/<midir>/dockerfiles/
BUILD_DIR=$DIR/jupyterlab/geopython/$JUPYTERLAB_VERSION
```

Clone:

```
git clone https://github.com/palmoreck/dockerfiles.git $DIR
```

Build:

```
docker build $BUILD_DIR --force-rm -t $REPO_URL:$JUPYTERLAB_VERSION
```

Run:

```
docker run -v $(pwd):/datos --name jupyterlab_geopython -p 8888:8888 -d $REPO_URL:$JUPYTERLAB_VERSION
```

or:

```
docker run --rm -v $(pwd):/datos --name jupyterlab_geopython -p 8888:8888 -d $REPO_URL:$JUPYTERLAB_VERSION
```

## jupyter lab running at localhost:8888 , password: qwerty

(not necessary) Enter to docker container with:

```
docker exec -it -u=miuser jupyterlab_geopython bash
```

Stop:

```
docker stop jupyterlab-local
```

Delete (if `--rm` wasn't used):


```
docker rm jupyterlab_geopython
```