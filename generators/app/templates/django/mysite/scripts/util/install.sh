#!/bin/bash
set -e

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt install software-properties-common python-software-properties
    sudo add-apt-repository ppa:pypa/ppa
    sudo apt update
    sudo apt-get install python3 pipenv libpq-dev redis-server
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install python3 pipenv postgresql redis
fi

exit
