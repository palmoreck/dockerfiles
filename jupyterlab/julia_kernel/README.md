Set:

```
JUPYTERLAB_VERSION=2.1.4
REPO_URL=palmoreck/jupyterlab_julia_kernel_1.5.0-beta1
DIR=/home/<user>/<midir>/dockerfiles/
BUILD_DIR=$DIR/jupyterlab/prope/$JUPYTERLAB_VERSION
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
docker run --rm -v $(pwd):/datos --name jupyterlab_julia_kernel -p 8888:8888 -d $REPO_URL:$JUPYTERLAB_VERSION
```

or:

```
docker run --rm -v $(pwd):/datos --name jupyterlab_julia_kernel -p 8888:8888 -d $REPO_URL:$JUPYTERLAB_VERSION
```

## jupyter lab running at localhost:8888 , password: qwerty

(not necessary) Enter to docker container with:

```
docker exec -it -u=miuser jupyterlab_julia_kernel bash
```

Stop:

```
docker stop jupyterlab_julia_kernel
```

Delete (if `--rm` wasn't used):


```
docker rm jupyterlab_julia_kernel
```


