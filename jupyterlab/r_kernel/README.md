Set:

```
JUPYTERLAB_VERSION=1.1.0
REPO_URL=palmoreck/jupyterlab_r_kernel
BUILD_DIR=/home/user/midir
```

Build:

```
docker build $BUILD_DIR --force-rm -t $REPO_URL:$JUPYTERLAB_VERSION
```

Run:

```
docker run -v $(pwd):/datos --name micontenedor -p 8888:8888 -d $REPO_URL:$JUPYTERLAB_VERSION
```

or:

```
docker run --rm -v $(pwd):/datos --name micontenedor -p 8888:8888 -d $REPO_URL:$JUPYTERLAB_VERSION
```

## jupyter lab running at localhost:8888 
## password: qwerty

(not necessary) Enter to docker container with:

```
docker exec -it -u=miuser micontenedor bash
```

Stop:

```
docker stop micontenedor
```

Delete (if `--rm` wasn't used):


```
docker rm micontenedor
```


