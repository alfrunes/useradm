#!/bin/bash

# tests are supposed to be located in the same directory as this file

DIR=$(readlink -f $(dirname $0))

export PYTHONDONTWRITEBYTECODE=1

HOST=${HOST="mender-useradm:8080"}

# if we're running in a container, wait a little before starting tests
[ $$ -eq 1 ] && sleep 10

py.test -s --tb=short --host $HOST \
          --internal-spec $DIR/internal_api.yml \
          --management-spec $DIR/management_api.yml \
          --verbose --junitxml=$DIR/results.xml \
          $DIR/tests/test_*.py "$@"
