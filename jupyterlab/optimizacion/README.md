Set:

```
JUPYTERLAB_VERSION=3.2.8
REPO_URL=palmoreck/jupyterlab_optimizacion
DIR=/home/<user>/<midir>/dockerfiles/ #path where this git repository is cloned, example: /home/user/dockerfiles
BUILD_DIR=$DIR/jupyterlab/optimizacion/$JUPYTERLAB_VERSION
CONTAINER_NAME=jupyterlab_optimizacion
```

Clone:

```
git clone https://github.com/palmoreck/dockerfiles.git $DIR
```

Build:

```
docker build $BUILD_DIR --force-rm -t $REPO_URL:$JUPYTERLAB_VERSION
```


## Running `jupyterlab_optimizacion` docker image in a docker container

```
docker run -v $(pwd):/datos --name $CONTAINER_NAME -p 8888:8888 -d $REPO_URL:$JUPYTERLAB_VERSION
```

or (recommended):

```
docker run --rm -v $(pwd):/datos --name $CONTAINER_NAME -p 8888:8888 -d $REPO_URL:$JUPYTERLAB_VERSION
```

**Note: in some systems (Windows e.g.) possibly need to use "$(pwd):/datos"**


## jupyter lab running at localhost:8888 , password: qwerty

(not necessary) Enter to docker container with:

```
docker exec -it -u=miuser $CONTAINER_NAME bash
```

Stop:

```
docker stop $CONTAINER_NAME
```

Delete (if `--rm` wasn't used):


```
docker rm $CONTAINER_NAME
```

