#!/bin/bash
set -e

pipenv run honcho -f Procfile.dev start

exit
