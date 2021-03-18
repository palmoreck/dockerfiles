Set:

```
OPT_VERSION=0.1
REPO_URL=palmoreck/kale_titanic_example
DIR=/home/<user>/<midir>/dockerfiles/ #path where this git repository is cloned, example: /home/user/dockerfiles
BUILD_DIR=$DIR/jupyterlab/kale/titanic_example/$OPT_VERSION
CONTAINER_NAME=jupyterlab_kale_titanic_example
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
docker run -v $(pwd):/datos --name $CONTAINER_NAME -p 8888:8888 -d $REPO_URL:$JUPYTERLAB_VERSION
```

or:

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
