#!/bin/bash

# create the database
mkdir -p tmp/postgres
# TODO: maybe check if it already exists
initdb tmp/postgres
