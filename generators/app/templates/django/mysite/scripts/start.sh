#!/bin/bash
set -e

PIPENV_VENV_IN_PROJECT=1 PYTHONUNBUFFERED=1 pipenv run honcho -f Procfile.dev start

exit
