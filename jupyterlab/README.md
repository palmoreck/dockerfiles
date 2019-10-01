JUPYTERLAB_VERSION=1.1.0
REPO_URL=palmoreck/jupyterlab
BUILD_DIR=/home/user/midir

docker build $BUILD_DIR --force-rm -t $REPO_URL:$JUPYTERLAB_VERSION

docker run --name micontenedor -p 8888:8888 -dit $REPO_URL:$JUPYTERLAB_VERSION bash
