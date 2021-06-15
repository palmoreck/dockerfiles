Set:

```
JUPYTERLAB_VERSION=3.0.16
REPO_URL=palmoreck/jupyterlab
BUILD_DIR=/home/user/midir
```

Build:

```
docker build $BUILD_DIR --force-rm -t $REPO_URL:$JUPYTERLAB_VERSION
```

Run:

```
docker run -v $(pwd):/shared_volume --name jupyterlab-local -p 8888:8888 -d $REPO_URL:$JUPYTERLAB_VERSION
```

or:

```
docker run --rm -v $(pwd):/shared_volume --name jupyterlab-local -p 8888:8888 -d $REPO_URL:$JUPYTERLAB_VERSION
```

## jupyter lab running at localhost:8888 , password: qwerty

(not necessary) Enter to docker container with:

```
docker exec -it -u=miuser jupyterlab-local bash
```

Stop:

```
docker stop jupyterlab-local
```

Delete (if `--rm` wasn't used):


```
docker rm jupyterlab-local
```


