Set:

```
JUPYTERLAB_VERSION_AND_CUDA=1.1.0_10.2
REPO_URL=palmoreck/jupyterlab_nvidia_cupy
DIR=/home/<user>/<midir>/dockerfiles/
BUILD_DIR=$DIR/jupyterlab/nvidia/cupy/$JUPYTERLAB_VERSION_AND_CUDA
```

Clone:

```
git clone https://github.com/palmoreck/dockerfiles.git $DIR
```

Build:

```
docker build $BUILD_DIR --force-rm -t $REPO_URL:$JUPYTERLAB_VERSION_AND_CUDA
```


Run:

```
docker run --gpus all -v $(pwd):/datos --name jupyterlab_nvidia_cupy_container -p 8888:8888 -d $REPO_URL:$JUPYTERLAB_VERSION_AND_CUDA
```

or:

```
docker run --gpus all --rm -v $(pwd):/datos --name jupyterlab_nvidia_cupy_container -p 8888:8888 -d $REPO_URL:$JUPYTERLAB_VERSION_AND_CUDA
```

## jupyter lab running at localhost:8888 , password: qwerty

(not necessary) Enter to docker container with:

```
docker exec -it -u=miuser jupyterlab_nvidia_cupy_container bash
```

Stop:

```
docker stop jupyterlab_nvidia_cupy_container
```

Delete (if `--rm` wasn't used):


```
docker rm jupyterlab_nvidia_cupy_container
```


