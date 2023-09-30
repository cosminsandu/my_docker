# my_docker

Requirement:
- [Docker](https://docs.docker.com/get-docker/)

## Services
 - web server (nginx)

## Commands
```bash
docker compose up     # compose/create the container(s)
docker compose up -d  # compose/create the container(s) in detatch mode


docker ps           # List containers
docker compose ps   # List services

docker exec -it [CONTAINER] [COMMAND]
docker exec -it my_docker-web-1 bash
docker exec -it my_docker-web-1 sh
```