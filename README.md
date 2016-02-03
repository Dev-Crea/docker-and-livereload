# README

This project is an example to configuration between docker, rails and
guard-livereload.

## Using in development mode
```Linux
# Build project :
docker-compose -f docker-compose.yml -f docker-compose.development.yml build

# Launch project :
docker-compose -f docker-compose.yml -f docker-compose.development.yml up
```

## Using in production mode
```Linux
# Build project :
docker-compose -f docker-compose.yml -f docker-compose.production.yml build

# Launch project :
docker-compose -f docker-compose.yml -f docker-compose.production.yml up -d
```

## Tips
```
# Use Rails Console :
docker-compose run web rails c
```

## Use script work
```Linux
# Use script for development ENV
sh work.sh -e development

# Use script for production ENV
sh work.sh -e production
```
