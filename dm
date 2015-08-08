#!/bin/bash

dm () {

  if [[ $1 == "use" ]]; then

    if [[ $2 == "local" ]]; then
      eval DOCKER_TLS_VERIFY=""
      eval DOCKER_HOST=""
      eval DOCKER_CERT_PATH=""
      eval DOCKER_MACHINE_NAME=""
      echo "Docker enviroment vars unset"
      return
    fi

    ENV=$(docker-machine env $2)
    ENV_OK=$?

    if [[ ENV_OK -eq 0 ]]; then
      eval "$(docker-machine env $2)"
      echo "Now using docker machine $DOCKER_MACHINE_NAME"
      return
    else
      echo $ENV
      echo "OH NO"
      return ENV_OK
    fi
  else
    return docker-machine $*
  fi

}