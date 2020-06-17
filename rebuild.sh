#!/usr/bin/env bash

set -e

handle_no_args() {
    echo "handling no args"
    echo -e
    echo "services: "
    docker-compose config --services
    echo -e
    read -p "type services you want to rebuild: " args
    rebuild $args
}

handle_args() {
    echo "handling args"
    rebuild $@
}

rebuild() {
    echo "rebuilding: " $@
    docker-compose rm -s -f $@
    docker-compose --log-level WARNING build --parallel $@
    docker-compose --log-level WARNING up --remove-orphans -d $@
}

if [[ $# -eq 0 ]];
  then
    handle_no_args
  else
    handle_args $@
fi