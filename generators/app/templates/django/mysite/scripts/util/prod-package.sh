#!/bin/bash

source ./scripts/util/env.sh

# build the frontend
(cd $FRONTEND_NAME; npm build)

# clean out files
mkdir -p prod
if [ -d ./prod/.git ]; then
  (cd prod; git rm -rf .; git clean -fxd)
else
  (rm -rf ./prod/*)
fi

# copy all of the backend and only the build frontend
rsync -avm \
    --include=$FRONTEND_NAME/build \
    --exclude-from=./.gitignore \
    --exclude=.git \
    --exclude=$PROJECT_NAME/static \
    --exclude=scripts \
    --exclude="$FRONTEND_NAME/*" \
    . prod

# move the frontend to its place
mv prod/$FRONTEND_NAME/build prod/$PROJECT_NAME/static
rmdir prod/$FRONTEND_NAME

# add a production gitignore
cp ./scripts/util/prod-gitignore prod/.gitignore
