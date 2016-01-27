# README

This project is an example to configuration between docker, rails and
guard-livereload.

## Using
```Linux
# Build project :
docker-compose build

# Launch project :
docker-compose up

# Use Rails Console :
docker-compose run web rails c
```

## to do
Prepare mode for development and production :
* Development mode using guard-livereload
* Production mode don't use guard-livereload
