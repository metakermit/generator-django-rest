FROM python:3.7
ENV PIPENV_VENV_IN_PROJECT=1
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
RUN pip install pipenv
COPY Pipfile Pipfile
COPY Pipfile.lock Pipfile.lock
RUN pipenv install --system --dev
COPY . /code
