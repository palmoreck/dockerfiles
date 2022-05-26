
```
docker build 1.8.1/ -t palmoreck/streamlit:1.8.1
```

```
docker run --rm -d -p 8501:8501 --name streamlit palmoreck/streamlit:1.8.1
```

Some refs:

https://share.streamlit.io/joshmantova/eagle-vision/prod/src/Project_Eagle_Vision.py

https://github.com/Joshmantova/Eagle-Vision/blob/prod/src/Project_Eagle_Vision.py

https://github.com/Joshmantova/Eagle-Vision/blob/prod/tests/test_predict.py

https://github.com/Joshmantova/Eagle-Vision/blob/prod/requirements.txt

https://github.com/Joshmantova/Eagle-Vision/blob/prod/Dockerfile


https://github.com/streamlit/streamlit

https://github.com/streamlit/streamlit/blob/develop/examples/file_uploader.py

https://docs.streamlit.io/streamlit-cloud/get-started/deploy-an-app

https://docs.streamlit.io/knowledge-base/tutorials/databases/aws-s3
