#!/bin/bash

if [ ! -d ./prod/.git ]; then
    echo "* prod git branch not initialised. Doing it now"
    ./scripts/util/prod-prepare.sh
else
    echo "* commiting new changes on the prod branch"
    cd prod
    git checkout prod
    git add -A
    datestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    git commit -m "Update $datestamp"
    git push -u origin prod
    cd ..
fi
