#!/bin/bash
# Author : VAILLANT Jérémy <vaillant.jeremy@dev-crea.com>
# Description :
# Script for starting apps in development or production mode with docker and
# docker-compose. Use option script for customize image and container.

## Variable script
# Command default for each docker-compose command
MODE="development"
COMP="docker-compose -f docker-compose.yml -f docker-compose.$MODE.yml "
VERS="0.1"
# Couleurs
VERT="\\033[1;32m"
NORMAL="\\033[0;39m"
ROUGE="\\033[1;31m"
BLEU="\\033[1;34m"
JAUNE="\\033[1;33m"

## Functions scripts
# Error information
error() {
  echo $ROUGE "ERROR : invalid parameters !" $NORMAL
  echo $ROUGE "Use -h for displaying help message" $NORMAL
  exit 1
}

# Help for use script
usage() {
  echo "Usage : sh work.sh [options]"
  echo "-h : display help (this message)"
  echo "-e <mode> : production or development - default development"
  #echo "-b <command> : options for building image"
  #echo "    nocache [--no-cache]"
  #echo "    forcerm [--force-rm]"
  #echo "    pull [--pull])"
  #echo "-u <command> : options for up container - default for production env -d"
  #echo "    d [-d]"
  #echo "    forcerecreate [--force-recreate]"
  #echo "    norecreate [--no-recreate]"
  #echo "    nobuild [--no-build]"
  echo "-v : program version"
  echo ""
  echo "## Exemple :"
  echo "sh work.sh -e development -b nocache"
  echo "Lance le docker dans un environement development et build sans cache"
  exit 0
}

# Display version program
version() {
  echo "Version : $VERS"
  exit 0
}

# Environment select
prepare() {
  MODE=$1
  if [ "$MODE" = "development" ] || [ "$MODE" = "production" ]; then
    echo $ROUGE "Preparation de l'environement : $MODE" $NORMAL
    if [ "$MODE" = "production" ]; then
      echo $ROUGE "Mise a jour du repository" $NORMAL
      git pull
    fi
    echo $ROUGE "Copie du Dockerfile correspondant a l'environment" $NORMAL
    cp Dockerfile.$MODE Dockerfile
    if [ -e ".dockerignore.$MODE" ]; then
      cp .dockerignore.$MODE .dockerignore
    fi
  else
    error
  fi
}

# Build image
build() {
  echo $VERT "BUILD image env $MODE" $NORMAL

  if [ "$MODE" = "development" ]; then
    $COMP stop
    $COMP rm -fv
    $COMP build --force-rm --no-cache
  fi

  if [ "$1" = "production" ]; then
    $COMP build
  fi
}

# Create container
up() {
  echo $JAUNE "UP container env $MODE" $NORMAL
  if [ "$MODE" = "development" ]; then
    $COMP up
  fi

  if [ "$1" = "production" ]; then
    $COMP up -d
    $COMP run web rake assets:precompile
    $COMP restart web
  fi
}

## Test script no args
if [ $# -eq "0" ]; then
  error
fi

## Execution loop script
while getopts "hve:b:u:" option; do
  case "$option" in
    e)
      prepare $2
      build
      up
      shift 2
      ;;
    #b)
    #  build $2
    #  shift 2
    #  ;;
    #u)
    #  up $2
    #  shift 2
    #  ;;
    h)
      usage
      ;;
    v)
      version
      ;;
    *)
      error
      ;;
  esac
done