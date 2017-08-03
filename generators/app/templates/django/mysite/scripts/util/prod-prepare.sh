#!/bin/bash

source ./scripts/util/env.sh

# TODO: only if remote doesn't have the prod branch
mkdir -p prod
cd prod
git init
if [[ ! -z $GIT_URL ]]; then
  git remote add origin $GIT_URL
fi
if [[ ! -z $HEROKU_URL ]]; then
  git remote add heroku $HEROKU_URL
fi
# TODO: add heroku remote
git checkout -b prod
echo "# The production branch" > README.md
git add -A
git commit -m "initial commit"
git push -u origin prod
cd ..
