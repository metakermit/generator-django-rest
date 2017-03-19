#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    sudo apt-get install libpq-dev rabbitmq-server
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install --dry-run postgresql rabbitmq
fi

exit
