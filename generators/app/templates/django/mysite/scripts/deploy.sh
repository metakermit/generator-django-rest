#!/bin/bash

gulp
gulp commit
(cd prod; git push heroku prod:master)
