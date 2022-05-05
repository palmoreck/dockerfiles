import datetime
import os
import time
import io
from PIL import Image
from dotenv import load_dotenv

import streamlit as st
import boto3


if __name__ == '__main__':
    dotenv_path = os.path.join(os.path.expanduser('~'), '.env')
    load_dotenv(dotenv_path)
    ACCESS_KEY = os.environ.get("ACCESS_KEY", "")
    AWS_SECRET_ACCESS_KEY = os.environ.get("AWS_SECRET_ACCESS_KEY", "")
    BUCKET = os.environ.get("BUCKET", "")
    st.title("Hello World!")
    instructions = """Here the instructions"""
    st.write(instructions)
    dst = "streamlit"
    date_today = datetime.date.today().strftime("%d-%m-%Y")
    file = st.file_uploader('Upload An Image')
    if file:
        #see: https://stackoverflow.com/questions/46204514/uploading-pil-image-object-to-amazon-s3-python
        img = Image.open(file)
        in_mem_file = io.BytesIO()
        img.save(in_mem_file, format=img.format)
        in_mem_file.seek(0)
        s3 = boto3.client("s3", aws_access_key_id=ACCESS_KEY, aws_secret_access_key=AWS_SECRET_ACCESS_KEY)
        key = os.path.join(dst, date_today, "img_for_rekog" + "." + img.format)
        s3.upload_fileobj(in_mem_file, BUCKET, key)
        st.write("Model predict ...")
        time.sleep(15)
        st.write("Just wait a few seconds more ...")
        time.sleep(7)
        st.write("Done!")
        st.write("The image is from class:")
        st.write("Deleting image from s3 bucket")
        s3.delete_object(Bucket=BUCKET, Key=key)
