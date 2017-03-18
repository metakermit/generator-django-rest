#!/bin/bash

# TODO: only if remote doesn't have the prod branch
mkdir prod
cd prod
git init
git remote add origin git@github.com:metakermit/posterbat.git
# TODO: add heroku remote
git checkout -b prod
echo "# The production branch" > README.md
git add .
git commit -m "initial commit"
git push -u origin prod
cd ..
