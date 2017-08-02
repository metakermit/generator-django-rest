#!/bin/bash

source ./scripts/util/env.sh

# TODO: only if remote doesn't have the prod branch
mkdir -p prod
cd prod
git init
git remote add origin $GIT_URL
# TODO: add heroku remote
git checkout -b prod
echo "# The production branch" > README.md
git add -A
git commit -m "initial commit"
git push -u origin prod
cd ..
