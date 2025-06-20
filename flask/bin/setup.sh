#!/usr/bin/env bash

set -e

# pyenv
curl https://pyenv.run | bash

pyenv versions
# install
pyenv install 3.12.0
# set local version
pyenv local 3.12.0

# create virtualenv
python3 -m venv ../myenv

# activate virtualenv
pyenv activate ../myenv
