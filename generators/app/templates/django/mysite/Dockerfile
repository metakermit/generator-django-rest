FROM python:3.5
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/requirements.txt
ADD requirements* /code/requirements/
RUN pip install -r requirements.txt
ADD . /code/
