#!/bin/bash

set -e

DB_PORT=5433
PROJECT_NAME=<%= project_name %>

# backend stuff
# -------------

## Python setup
# create venv if not there (use venv)
python3 -m venv venv
# activate it
source ./venv/bin/activate

# create the .env file
if [ ! -f .env ]; then
    echo "* creating initial .env file"
    cp .env.example .env
else
    echo "* .env file already exists"
fi

# create the Procfile.dev file
if [ ! -f Procfile.dev ]; then
    echo "* creating initial Procfile.dev file"
    cp Procfile.dev.example Procfile.dev
else
    echo "* Procfile.dev file already exists"
fi

# install requirements
echo "* install dev requirements"
./venv/bin/pip install -r requirements/dev.txt

# create the database
if [ ! -d tmp/postgres ]; then
    echo "* initialising the DB"
    mkdir -p tmp/postgres
    initdb tmp/postgres
    postgres -D tmp/postgres -p $DB_PORT & echo $! > tmp/postgres.pid
    sleep 3
    psql postgres -p $DB_PORT -c "create user ${PROJECT_NAME} with password '${PROJECT_NAME}';"
    psql postgres -p $DB_PORT -c "create database ${PROJECT_NAME} encoding 'utf8' template template0 owner ${PROJECT_NAME};"
    sleep 3
    ./venv/bin/python manage.py migrate
    kill `cat tmp/postgres.pid`
    echo "* DB ready"
else
    echo "* the DB already exists"
fi

# frontend stuff
# -------------

# maybe run initial `gulp build`

# create empty branch to store the minified code
# this is done by the gulp task automatically, it seems
# git checkout --orphan prod

# link to UI
if [ ! -e "${PROJECT_NAME}/static" ]; then
    echo "* linking Django app to the JS frontend"
    CURDIR=`pwd`
    cd ${PROJECT_NAME}
    ln -s ../dist static
    cd $CURDIR
else
    echo "* frontend already linked"
fi

# app-specific
#-------------
./scripts/util/devsetup-custom.sh

echo "* DONE :)"
