Set:

```
POSTGRESQL_VERSION=12
DIST=bionic
REPO_URL=palmoreck/postgresql
BUILD_DIR=/home/user/midir
MOUNT_DIR=/home/user/mimount
```


Build:

```
sudo docker build $BUILD_DIR --build-arg \
POSTGRESQL_VERSION=$POSTGRESQL_VERSION --force-rm -t $REPO_URL:${DIST}_${POSTGRESQL_VERSION}
```

Run:

```
docker run -v $MOUNT_DIR/etc/postgresql:/etc/postgresql \
-v $MOUNT_DIR/var/log/postgresql:/var/log/postgresql \
-v $MOUNT_DIR/var/lib/postgresql:/var/lib/postgresql \
-w /home/postgres \
-p 2225:22 -p 5432:5432 --name postgresql-local --hostname postgresql \
-d $REPO_URL:${DIST}_${POSTGRESQL_VERSION}
```

or:

```
docker run --rm -v $MOUNT_DIR/etc/postgresql:/etc/postgresql \
-v $MOUNT_DIR/var/log/postgresql:/var/log/postgresql \
-v $MOUNT_DIR/var/lib/postgresql:/var/lib/postgresql \
-w /home/postgres \
-p 2225:22 -p 5432:5432 --name postgresql-local --hostname postgresql \
-d $REPO_URL:${DIST}_${POSTGRESQL_VERSION}
```


wait a few minutes, check with:

```
docker logs postgresql-local|tail -n 5
```

until it says:

```
database system is ready to accept connections
```

enter with:

```
docker exec -it -u=postgres postgresql-local bash   
```

and create extensions or new databases. For instance run:


```
psql -h localhost 
```

password: `postgres`


Stop:

```
docker stop postgresql-local
```

Delete (if --rm wasn't used):

```
docker rm postgresql-local
```
