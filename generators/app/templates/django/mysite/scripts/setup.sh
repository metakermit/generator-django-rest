#!/bin/bash
set -e

source ./scripts/util/env.sh
source ./scripts/util/check-os-deps.sh

# backend stuff
# -------------

## Python setup

# create the .env file
if [ ! -f .env ]; then
    echo "* creating initial .env file"
    cp .env.example .env
else
    echo "* .env file already exists"
fi

# create and/or activate the virtualenv and install the requirements
# (keep virtualenv in the project folder's .venv for better shell support)
echo "* install dev requirements"
PIPENV_VENV_IN_PROJECT=1 pipenv install --dev

# create the Procfile.dev file
if [ ! -f Procfile.dev ]; then
    echo "* creating initial Procfile.dev file"
    cp Procfile.dev.example Procfile.dev
else
    echo "* Procfile.dev file already exists"
fi

# create the database
# - if there is something already running on the database port, quit
# (this script assumes you want to run a local postgres instance)
if lsof -Pi :$DB_PORT -sTCP:LISTEN -t >/dev/null ; then
    lsof -iTCP:$DB_PORT -sTCP:LISTEN
    PID_TO_KILL=$(lsof -Pi :$DB_PORT -sTCP:LISTEN -t)
    echo "* process already running on port $DB_PORT, can't set up a new database. Please kill it to proceed:"
    echo "kill $PID_TO_KILL"
    exit 1
else
    echo "* port $DB_PORT free, so we're good to go..."
fi
# ok, we're safe to start the postgres process
if [ ! -d tmp/postgres ]; then
    echo "* initialising the DB"
    mkdir -p tmp/postgres
    initdb tmp/postgres
    postgres -D tmp/postgres -p $DB_PORT & echo $! > tmp/postgres.pid
    sleep 3
    psql postgres -p $DB_PORT -c "create user ${PROJECT_NAME_LOWERCASE} with password '${PROJECT_NAME_LOWERCASE}';"
    psql postgres -p $DB_PORT -c "create database ${PROJECT_NAME_LOWERCASE} encoding 'utf8' template template0 owner ${PROJECT_NAME_LOWERCASE};"
    sleep 3
    pipenv run python manage.py migrate
    kill `cat tmp/postgres.pid`
    echo "* DB ready"
else
    echo "* the DB already exists, checking if it needs migrations"
    postgres -D tmp/postgres -p $DB_PORT & echo $! > tmp/postgres.pid
    sleep 3
    pipenv run python manage.py migrate
    kill `cat tmp/postgres.pid`
fi

# frontend stuff
# -------------
<% if (prod_branch) { %>
if [ ! -d $FRONTEND_NAME ]; then
    create-react-app $FRONTEND_NAME
fi
# build the frontend
(cd $FRONTEND_NAME; npm install)
./scripts/util/prod-package.sh
<% } else { %>
# optionally compile your frontend code here
<% } %>
# link to UI
if [[ ! -e ${PROJECT_NAME}/static && ! -L ${PROJECT_NAME}/static ]]; then
    echo "* linking Django app to the JS frontend"
    CURDIR=`pwd`
    cd ${PROJECT_NAME}
    ln -s ../${FRONTEND_NAME}/build static
    cd $CURDIR
else
    echo "* frontend already linked"
fi

# app-specific
#-------------
./scripts/util/setup-custom.sh

if [ -d .git ]; then
    echo "* git repo detected, won't commit anything automatically"
else
    echo "* initialising the git repo"
    git init
    git add -A
    git commit -m "yo django-rest"
fi
# set git remotes
if [[ ! -z $GIT_URL ]]; then
    echo "* setting git remote"
    git remote add origin $GIT_URL
fi
<% if (!prod_branch) { %>
if [[ ! -z $HEROKU_URL ]]; then
    echo "* setting heroku remote"
    git remote add heroku $HEROKU_URL
fi
<% } %>

echo "* DONE :)"

exit
