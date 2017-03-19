#!/bin/bash

source ./.venv/bin/activate
honcho -f Procfile.dev start
