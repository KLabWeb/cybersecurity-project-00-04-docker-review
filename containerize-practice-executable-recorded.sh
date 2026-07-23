#!/bin/bash

# Docker commands review script
# Playing with container lifecycle, images, containers, volumes, networks, and more
# Serves a FastAPI app via Uvicorn via compose after playtime is over

# Get docker version
echo -e "\n# Get docker version"
echo '$ docker version'
read -p ''
docker version

# Reset Docker to a clean slate before running
read -p ''
echo -e "\n# Reset Docker to a clean slate before running"
echo -e '\nAll docker images, containers, and volumes on system will be deleted. Type "DELETE EVERYTHING" and press Enter to continue.'
read kill_it_all

if [ "$kill_it_all" != "DELETE EVERYTHING" ]; then
    echo -e "Cancelled — nothing was deleted."
    exit 1
fi

echo -e "\nProceeding with nuclear cleanup...\n"
echo '$ docker compose down -v 2>/dev/null'
docker compose down -v 2>/dev/null
echo '$ docker rm -f $(docker ps -aq) 2>/dev/null'
docker rm -f $(docker ps -aq) 2>/dev/null
echo '$ docker rmi -f $(docker images -q) 2>/dev/null'
docker rmi -f $(docker images -q) 2>/dev/null
echo '$ docker system prune -af --volumes'
docker system prune -af --volumes

# Pull test image & verify pull
read -p ''
echo -e "\n\n# Pull test image & verify pull"
echo '$ docker pull nginx:latest'
read -p ''
docker pull nginx:latest
read -p ''
echo '$ docker image ls'
read -p ''
docker image ls

# Start container w/ custom name & verify running
read -p ''
echo -e "\n\n# Start container w/ custom name & verify running"
echo '$ docker run -dit --name nginx-test nginx'
read -p ''
docker run -dit --name nginx-test nginx
read -p ''
echo '$ docker ps'
read -p ''
docker ps
read -p ''
echo '$ ps -ef | grep nginx'
read -p ''
ps -ef | grep nginx

# Attach container to terminal
read -p ''
echo -e "\n\n# Attach container to terminal"
echo -e "Enter container ID then press enter to attach to container"
read container_id
echo "$ docker attach $container_id"
read -p ''
docker attach $container_id
read -p ''
echo "$ docker stop $container_id"
read -p ''
docker stop $container_id
read -p ''
echo '$ docker start nginx-test'
read -p ''
docker start nginx-test

# Run container w/ env var & verify var set
read -p ''
echo -e "\n\n# Run container w/ env var & verify var set"
echo '$ docker pull mysql:latest'
read -p ''
docker pull mysql:latest
read -p ''
echo '$ docker run -d --name mysql-test --env MYSQL_RANDOM_ROOT_PASSWORD=yes mysql'
read -p ''
docker run -d --name mysql-test --env MYSQL_RANDOM_ROOT_PASSWORD=yes mysql
read -p ''
echo '$ docker ps'
read -p ''
docker ps
read -p ''
echo -e "\nWaiting for MySQL to initialize...\n"
echo '$ sleep 15'
sleep 15
echo '$ docker logs mysql-test 2>&1 | grep "GENERATED ROOT PASSWORD"'
read -p ''
docker logs mysql-test 2>&1 | grep "GENERATED ROOT PASSWORD"

# Pull and run older version mysql and latest ver mysql in diff containers
read -p ''
echo -e "\n\n# Pull and run older version mysql and latest ver mysql in diff containers"
echo '$ docker pull mysql:8.4'
read -p ''
docker pull mysql:8.4
read -p ''
echo -e '\n$ docker run -d --name mysql-old  --env MYSQL_RANDOM_ROOT_PASSWORD=yes mysql:8.4'
read -p ''
docker run -d --name mysql-old  --env MYSQL_RANDOM_ROOT_PASSWORD=yes mysql:8.4
read -p ''
echo '$ docker ps'
read -p ''
docker ps

# View image details for mysql
read -p ''
echo -e "\n\n# View image details for mysql"
echo '$ docker inspect mysql'
read -p ''
docker inspect mysql

# Stop, pause, unpause, and kill containers
read -p ''
echo -e "\n\n# Stop, pause, unpause, and kill containers"
echo '$ docker stop mysql-test'
read -p ''
docker stop mysql-test
read -p ''
echo '$ docker pause mysql-old'
read -p ''
docker pause mysql-old
read -p ''
echo '$ docker ps'
read -p ''
docker ps
read -p ''
echo '$ docker unpause mysql-old'
read -p ''
docker unpause mysql-old
read -p ''
echo '$ docker kill mysql-old'
read -p ''
docker kill mysql-old
read -p ''
echo '$ docker ps'
read -p ''
docker ps

# Remove mysql 8.4 container & image
read -p ''
echo -e "\n\n# Remove mysql 8.4 container & image"
echo '$ docker  ps -a'
read -p ''
docker  ps -a
read -p ''
echo '$ docker rm mysql-old'
read -p ''
docker rm mysql-old
read -p ''
echo '$ docker container ps -a'
read -p ''
docker container ps -a

# List images & remove mysql 8.4 image
read -p ''
echo -e "\n\n# List images & remove mysql 8.4 image"
echo '$ docker image ls'
read -p ''
docker image ls
read -p ''
echo '$ docker rmi mysql:8.4'
read -p ''
docker rmi mysql:8.4
read -p ''
echo '$ docker image ls'
read -p ''
docker image ls

# View container top processes, HW usage stats, metadata, & logs
read -p ''
echo -e "\n\n# View container top processes, HW usage stats, metadata, & logs"
echo '$ docker top nginx-test'
read -p ''
docker top nginx-test
read -p ''
echo '$ docker stats --no-stream nginx-test'
read -p ''
docker stats --no-stream nginx-test
read -p ''
echo '$ docker inspect nginx-test'
read -p ''
docker inspect nginx-test
read -p ''
echo '$ docker logs nginx-test'
read -p ''
docker logs nginx-test

# Run nginx container in interactive mode
read -p ''
echo -e "\n\n# Run nginx container in interactive mode"
echo '$ docker stop nginx-test'
read -p ''
docker stop nginx-test
read -p ''
echo '$ docker rm nginx-test'
read -p ''
docker rm nginx-test
read -p ''
echo '$ docker run --name nginx-test -it nginx bash'
read -p ''
docker run --name nginx-test -it nginx bash
read -p ''
echo '$ docker ps'
read -p ''
docker ps -a

# Start container in standard mode, then start in interactive using commands
# Note how I can now exit bash without container stopping, unlike when starting interactive
read -p ''
echo -e "\n\n# Start container in standard mode, then start in interactive using commands"
echo -e "# Note how I can now exit bash without container stopping, unlike when starting interactive"
echo '$ docker rm nginx-test'
read -p ''
docker rm nginx-test
read -p ''
echo '$ docker run -d --name nginx-test nginx'
read -p ''
docker run -d --name nginx-test nginx
read -p ''
echo '$ docker exec -it nginx-test bash'
read -p ''
docker exec -it nginx-test bash
read -p ''
echo '$ docker ps'
read -p ''
docker ps

# Start nginx with bridge between ports 8080 on host and 80 on container & verify port mapping
read -p ''
echo -e "\n\n# Start nginx with bridge between ports 8080 on host and 80 on container & verify port mapping"
echo '$ docker stop nginx-test'
read -p ''
docker stop nginx-test
read -p ''
echo '$ docker rm nginx-test'
read -p ''
docker rm nginx-test
read -p ''
echo '$ docker run -d --name nginx-test -p 8080:80 nginx'
read -p ''
docker run -d --name nginx-test -p 8080:80 nginx
read -p ''
echo '$ docker port nginx-test'
read -p ''
docker port nginx-test

# Explore networks, then create network and connect nginx-test to it, verify, then disconnect nginx, and remove network
read -p ''
echo -e "\n\n# Explore networks, then create network and connect nginx-test to it, verify, then disconnect nginx, and remove network"
echo '$ docker network ls'
read -p ''
docker network ls
read -p ''
echo '$ docker network inspect bridge'
read -p ''
docker network inspect bridge
read -p ''
echo '$ docker network create test-network'
read -p ''
docker network create test-network
read -p ''
echo '$ docker network connect test-network nginx-test'
read -p ''
docker network connect test-network nginx-test
read -p ''
echo '$ docker network ls'
read -p ''
docker network ls
read -p ''
echo '$ docker network inspect test-network | grep nginx-test'
read -p ''
docker network inspect test-network | grep nginx-test
read -p ''
echo '$ docker network disconnect test-network nginx-test'
read -p ''
docker network disconnect test-network nginx-test
read -p ''
echo '$ docker network inspect test-network | grep nginx-test'
read -p ''
docker network inspect test-network | grep nginx-test
read -p ''
echo '$ docker network rm test-network'
read -p ''
docker network rm test-network
read -p ''
echo '$ docker network ls'
read -p ''
docker network ls

# Remove all stopped containers, networks w/ no containers, dangling images, & build cache
read -p ''
echo -e "\n\n# Remove all stopped containers, networks w/ no containers, dangling images, & build cache"
echo '$ docker ps -a'
read -p ''
docker ps -a
read -p ''
echo '$ docker image ls'
read -p ''
docker image ls
read -p ''
echo '$ docker system prune'
read -p ''
docker system prune
read -p ''
echo '$ docker ps -a'
read -p ''
docker ps -a

# View history for mysql image
read -p ''
echo -e "\n\n# View history for mysql image"
echo '$ docker history mysql'
read -p ''
docker history mysql

# Pull image using organization name in pull tag, then add custom tag to the image
read -p ''
echo -e "\n\n# Pull image using organization name in pull tag, then add custom tag to the image"
echo '$ docker pull traefik/whoami'
read -p ''
docker pull traefik/whoami
read -p ''
echo '$ docker tag traefik/whoami special-whoami'
read -p ''
docker tag traefik/whoami special-whoami
read -p ''
echo '$ docker images | grep whoami'
read -p ''
docker images | grep whoami
read -p ''
echo '$ docker image rm special-whoami'
read -p ''
docker image rm special-whoami

# Build uvicorn-test container via dockerfile and verify server started w/o error, via:
read -p ''
echo -e "\n\n# Build uvicorn-test container via dockerfile and verify server started w/o error, via:"
echo '$ docker build -t uvicorn-test ./'
read -p ''
docker build -t uvicorn-test ./
read -p ''
echo '$ docker run -d --name uvicorn-test -p 8081:8081 uvicorn-test'
read -p ''
docker run -d --name uvicorn-test -p 8081:8081 uvicorn-test
read -p ''
echo -e "Waiting for Uvicorn to start..."
echo '$ sleep 3'
sleep 3
echo '$ docker logs uvicorn-test'
read -p ''
docker logs uvicorn-test
read -p ''
echo '$ curl http://localhost:8081/'
read -p ''
curl http://localhost:8081/

# List docker volumes on local machine
read -p ''
echo -e "\n\n# List docker volumes on local machine"
echo '$ docker volume ls'
read -p ''
docker volume ls

# Remove un-used volumes and list again
read -p ''
echo -e "\n\n# Remove un-used volumes and list again"
echo '$ docker volume prune'
read -p ''
docker volume prune
read -p ''
echo '$ docker volume ls'
read -p ''
docker volume ls

# Verify Docker Compose installed on system
read -p ''
echo -e "\n\n# Verify Docker Compose installed on system"
echo '$ docker compose version'
read -p ''
docker compose version

# Start my FastAPI over uvicorn demo app w/ live-reloading in isolated env w/ Docker Compose
read -p ''
echo -e "\n\n# Start my FastAPI over uvicorn demo app w/ live-reloading in isolated env w/ Docker Compose"
echo '$ docker rm -f uvicorn-test'
read -p ''
docker rm -f uvicorn-test
read -p ''
echo "$ trap 'echo -e \"\\n\\n# Watch stopped — continuing\"' INT"
trap 'echo -e "\n\n# Watch stopped — continuing"' INT
read -p ''
echo '$ docker compose watch'
read -p ''
docker compose watch
read -p ''
echo '$ trap - INT'
trap - INT

# Clean up again
read -p ''
echo -e "\n\n# Clean up again"
echo '$ docker compose down -v 2>/dev/null'
docker compose down -v 2>/dev/null
read -p ''
echo '$ docker rm -f $(docker ps -aq) 2>/dev/null'
docker rm -f $(docker ps -aq) 2>/dev/null
read -p ''
echo '$ docker rmi -f $(docker images -q) 2>/dev/null'
docker rmi -f $(docker images -q) 2>/dev/null
read -p ''
echo '$ docker system prune -af --volumes'
docker system prune -af --volumes

# Verify cleanup
read -p ''
echo -e "\n\n# Verify cleanup"
echo '$ docker ps -a          # should be empty'
read -p ''
docker ps -a          # should be empty
read -p ''
echo '$ docker images         # should be empty'
read -p ''
docker images         # should be empty
read -p ''
echo '$ docker volume ls      # should be empty'
read -p ''
docker volume ls      # should be empty
read -p ''
echo '$ docker network ls     # only the 3 defaults: bridge, host, none'
read -p ''
docker network ls     # only the 3 defaults: bridge, host, none

read -p ''
echo -e "\n\nScript complete! Docker review is over!"
