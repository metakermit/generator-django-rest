#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt-get install libpq-dev rabbitmq-server
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install postgresql rabbitmq
fi

exit
