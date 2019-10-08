Set:

```
POSTGRESQL_VERSION=12
REPO_URL=palmoreck/postgresql
BUILD_DIR=/Users/erick/Documents/erick/dockerfiles/postgresql/
```


Build:

```
docker build $BUILD_DIR --force-rm -t $REPO_URL:$POSTGRESQL_VERSION
```

Run:

```
docker run -v $BUILD_DIR/etc/postgresql:/etc/postgresql \
-v $BUILD_DIR/var/log/postgresql:/var/log/postgresql \
-v $BUILD_DIR/var/lib/postgresql:/var/lib/postgresql \
-w /home/postgres \
-p 2225:22 -p 5432:5432 --name postgresql-local --hostname postgresql \
-dit $REPO_URL:$POSTGRESQL_VERSION
```

or:

```
docker run --rm -v $BUILD_DIR/etc/postgresql:/etc/postgresql \
-v $BUILD_DIR/var/log/postgresql:/var/log/postgresql \
-v $BUILD_DIR/var/lib/postgresql:/var/lib/postgresql \
-w /home/postgres \
-p 2225:22 -p 5432:5432 --name postgresql-local --hostname postgresql \
-dit $REPO_URL:$POSTGRESQL_VERSION
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

and create extensions or new databases, for instance run:


```
psql -h localhost 
```

password: `postgres`


Stop:

```
docker stop micontenedor
```

Delete (if --rm wasn't used):

```
docker rm micontenedor
```
