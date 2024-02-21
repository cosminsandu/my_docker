# my_docker

This is my Docker for basic DEVELOPMENT!

Create a new project by clicking '`Use this template`' button.

For plain PHP (without Symfony framework) use the `php` branch.

For Symfony framework use `main` branch. <br>
To install symfony, access the `app` container and run `sh .docker/install-symfony.sh [version]` (version is optional, if not specified last stable version is installed)

Requirement:
- [Docker](https://docs.docker.com/get-docker/)

## Services
 - web server (nginx) [localhost](http://localhost/)
 - app (PHP 8.1 & composer & symfony CLI)
 - database (mysql 8.0)
 - cache (redis) -  OPTIONAL - commented
 - rabbitmq - commented
 - debug (xdebug) - requires [this chrome extension](https://chrome.google.com/webstore/detail/xdebug-helper/eadndfjplgieldjbigjakmdgkmoaaaoc)

## Commands
```bash
docker compose up     # compose/create the container(s)
docker compose up -d  # compose/create the container(s) in detatch mode
docker compose up --build -d  # build images
docker compose down   # Stop and remove containers, networks

docker ps           # List containers
docker compose ps   # List services

docker exec -it [CONTAINER] [COMMAND]
docker exec -it my_docker-app-1 sh
docker exec -it my_docker-app-1 bash

# set env variable
# linux
#XDEBUG_MODE=off docker compose up
# windows 
set XDEBUG_MODE=off&& docker compose up &set XDEBUG_MODE=
```


