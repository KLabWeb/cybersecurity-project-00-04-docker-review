#!/bin/bash

# Docker commands review script
# Playing with containers, container lifecycle, images, volumes, networks, and more
# Serves a FastAPI app via Uvicorn via compose after done with practice commands

# Get docker version
docker version

read -p "Press Enter to continue to the next step..."

# Reset Docker to a clean slate before running
echo -e "\n\n# Reset Docker to a clean slate before running"
echo 'All docker images, containers, and volumes on system will be deleted. Type "DELETE EVERYTHING" and press Enter to continue.'
read kill_it_all

if [ "$kill_it_all" != "DELETE EVERYTHING" ]; then
    echo -e "Cancelled — nothing was deleted."
    exit 1
fi

echo -e "Proceeding with nuclear cleanup..."
docker compose down -v 2>/dev/null
docker rm -f $(docker ps -aq) 2>/dev/null
docker rmi -f $(docker images -q) 2>/dev/null
docker system prune -af --volumes

read -p "Press Enter to continue to the next step..."

# Pull test image & verify pull
docker pull nginx:latest
docker image ls

read -p "Press Enter to continue to the next step..."

# Start container w/ custom name & verify running
docker run -dit --name nginx-test nginx
docker ps
ps -ef | grep nginx

#read -p "Press Enter to continue to the next step..."

# Attach container to terminal
echo -e "Enter container ID then press enter to attach to container"
read container_id
docker attach $container_id
docker stop $container_id
docker start nginx-test

read -p "Press Enter to continue to the next step..."

# Run container w/ env var & verify var set
docker pull mysql:latest
docker run -d --name mysql-test --env MYSQL_RANDOM_ROOT_PASSWORD=yes mysql
docker ps
sleep 15
docker logs mysql-test 2>&1 | grep "GENERATED ROOT PASSWORD"

read -p "Press Enter to continue to the next step..."

# Pull and run older version mysql and latest ver mysql in diff containers
docker pull mysql:8.4
docker run -d --name mysql-old  --env MYSQL_RANDOM_ROOT_PASSWORD=yes mysql:8.4
docker ps

read -p "Press Enter to continue to the next step..."

# Via image details for mysql
docker inspect mysql

read -p "Press Enter to continue to the next step..."

#Stop, pause, unpause, and kill containers
docker stop mysql-test
docker pause mysql-old
docker ps
docker unpause mysql-old
docker kill mysql-old
docker ps

read -p "Press Enter to continue to the next step..."

# Remove mysql 8.4 container & image
docker  ps -a
docker rm mysql-old
docker container ps -a

read -p "Press Enter to continue to the next step..."

# List images & remove mysql 8.4 image
docker image ls
docker rmi mysql:8.4
docker image ls

read -p "Press Enter to continue to the next step..."

# Via container top processes, HW usage stats, metadata, & logs
docker top nginx-test
docker stats --no-stream nginx-test
docker inspect nginx-test
docker logs nginx-test

read -p "Press Enter to continue to the next step..."

# Run nginx container in interactive mode
docker stop nginx-test
docker rm nginx-test
docker run --name nginx-test -it nginx bash
docker ps

#read -p "Press Enter to continue to the next step..."

# Start container in standard mode, then start in interactive using commands
# Note how I can now exit bash without container stopping, unlike when starting interactive
docker rm nginx-test
docker run -d --name nginx-test nginx
docker exec -it nginx-test bash
docker ps

#read -p "Press Enter to continue to the next step..."

# Start nginx with bridge between ports 8080 on host and 80 on container & verify port mapping
docker stop nginx-test
docker rm nginx-test
docker run -d --name nginx-test -p 8080:80 nginx
docker port nginx-test

read -p "Press Enter to continue to the next step..."

# Explore networks, then create network and connect nginx-test to it, verify, then disconnect nginx, and remove network
docker network ls
docker network inspect bridge
docker network create test-network
docker network connect test-network nginx-test
docker network ls
docker network inspect test-network | grep nginx-test
docker network disconnect test-network nginx-test
docker network inspect test-network | grep nginx-test
docker network rm test-network
docker network ls

read -p "Press Enter to continue to the next step..."

# Remove all stopped containers, networks w/ no containers, dangling images, & build cache
docker ps -a
docker image ls
docker system prune
docker ps -a

read -p "Press Enter to continue to the next step..."

# View history for mysql image
docker history mysql

read -p "Press Enter to continue to the next step..."

# Pull image using organization name in pull tag, then add custom tag to the image
docker pull traefik/whoami
docker tag traefik/whoami special-whoami
docker images | grep whoami
docker image rm special-whoami

read -p "Press Enter to continue to the next step..."

# Build uvicorn-test container via dockerfile and verify server started w/o error, via:
docker build -t uvicorn-test ./
docker run -d --name uvicorn-test -p 8081:8081 uvicorn-test
sleep 3
docker logs uvicorn-test
curl http://localhost:8081/

read -p "Press Enter to continue to the next step..."

# List docker volumes on local machine
docker volume ls

read -p "Press Enter to continue to the next step..."

# Remove un-used volumes and list again
docker volume prune
docker volume ls

read -p "Press Enter to continue to the next step..."

# Update linux apt repos and install Docker Compose
sudo apt-get update
sudo apt-get install -y docker-compose-plugin
docker compose version

read -p "Press Enter to continue to the next step..."

# Start my FastAPI over uvicorn demo app w/ live-reloading in isolated env w/ Docker Compose
docker rm -f uvicorn-test
trap 'echo -e "\n\n# Watch stopped — continuing"' INT
docker compose watch
trap - INT

read -p "Press Enter to continue to the next step..."

# Clean up again
docker compose down -v 2>/dev/null
docker rm -f $(docker ps -aq) 2>/dev/null
docker rmi -f $(docker images -q) 2>/dev/null
docker system prune -af --volumes

read -p "Press Enter to continue to the next step..."

# Verify cleanup
docker ps -a          # should be empty
docker images         # should be empty
docker volume ls      # should be empty
docker network ls     # only the 3 defaults: bridge, host, none

echo -e "\n\nScript complete! Docker review is over!"