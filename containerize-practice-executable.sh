#!/bin/bash

# Provisioning script for local docker WebGoat install via containers for WebGoat
# Plus nginx & postgres, for further Docker review

# Get docker version
echo -e "\n\n# Get docker version"
docker version

read -p "Press Enter to continue to the next step..."

# Reset Docker to a clean slate before running
echo -e "\n\n# Reset Docker to a clean slate before running"
echo -e 'All docker images, containers, and volumes on system will be deleted. Type "DELETE EVERYTHING" and press Enter to continue.'
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
echo -e "\n\n# Pull test image & verify pull"
docker pull nginx:latest
docker image ls

read -p "Press Enter to continue to the next step..."

# Start container w/ custom name & verify running
echo -e "\n\n# Start container w/ custom name & verify running"
docker run -d --name nginx-test nginx 
docker ps
ps -ef | grep nginx

#read -p "Press Enter to continue to the next step..."

# Attach container to terminal
# echo -e "\n\n# Attach container to terminal"
echo -e "Enter container ID then press enter to attach to container"
read container_id
docker attach $container_id
docker stop $container_id

read -p "Press Enter to continue to the next step..."

# Run container w/ env var & verify var set
echo -e "\n\n# Run container w/ env var & verify var set"
docker pull mysql
docker run -d --name mysql-test --env MYSQL_RANDOM_ROOT_PASSWORD=yes mysql
docker ps
docker logs mysql-test 2>&1 | grep "GENERATED ROOT PASSWORD"

read -p "Press Enter to continue to the next step..."

# Pull and run older version mysql and latest ver mysql in diff containers
echo -e "\n\n# Pull and run older version mysql and latest ver mysql in diff containers"
docker pull mysql:8.4
docker run -d --name mysql-old  --env MYSQL_RANDOM_ROOT_PASSWORD=yes mysql:8.4
docker ps

read -p "Press Enter to continue to the next step..."

# Via image details for mysql
echo -e "\n\n# Via image details for mysql"
docker inspect mysql

read -p "Press Enter to continue to the next step..."

#Stop, pause, and kill containers
echo -e "\n\n#Stop, pause, and kill containers"
docker stop mysql-test
docker pause mysql-old
docker ps
docker kill mysql-old
docker ps

read -p "Press Enter to continue to the next step..."

# Remove mysql 8.4 container & image
echo -e "\n\n# Remove mysql 8.4 container & image"
docker  ps -a
docker rm mysql-old
docker container ps -a

read -p "Press Enter to continue to the next step..."

# List images & remove mysql 8.4 image
echo -e "\n\n# List images & remove mysql 8.4 image"
docker image ls
docker rmi mysql:8.4
docker image ls

read -p "Press Enter to continue to the next step..."

# Via container top processes, HW usage stats, metadata, & logs
echo -e "\n\n# Via container top processes, HW usage stats, metadata, & logs"
docker top nginx-test
docker stats --no-stream nginx-test
docker inspect nginx-test
docker logs nginx-test

read -p "Press Enter to continue to the next step..."

# Run nginx container in interactive mode
# echo -e "\n\n# Run nginx container in interactive mode"
docker stop nginx-test
docker rm nginx-test
docker run --name nginx-test -it nginx bash
docker ps

#read -p "Press Enter to continue to the next step..."

# Start container in standard mode, then start in interactive using commands
# Not how I can now exit bash without container stopping, unlike when starting interactive
#echo -e "\n\n# Start container in standard mode, then start in interactive using commands"
#echo -e "\n\n# Not how I can now exit bash without container stopping, unlike when starting interactive"
docker rm nginx-test
docker run -d --name nginx-test nginx
docker exec -it nginx-test bash
ls
exit
docker ps

#read -p "Press Enter to continue to the next step..."

# Start nginx with bridge between ports 8080 on host and 80 on container & verify port mapping
echo -e "\n\n# Start nginx with bridge between ports 8080 on host and 80 on container & verify port mapping"
docker stop nginx-test
docker rm nginx-test
docker run -d --name nginx-test -p 8080:80 nginx
docker port nginx-test

read -p "Press Enter to continue to the next step..."

# Explore networks, then create network and connect nginx-test to it, verify, then disconnect nginx, and remove network
echo -e "\n\n# Explore networks, then create network and connect nginx-test to it, verify, then disconnect nginx, and remove network"
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
echo -e "\n\n# Remove all stopped containers, networks w/ no containers, dangling images, & build cache"
docker ps -a
docker image ls
docker system prune
docker ps -a

read -p "Press Enter to continue to the next step..."

# View history for mysql image
echo -e "\n\n# View history for mysql image"
docker history mysql

read -p "Press Enter to continue to the next step..."

# Pull OWASP WebGoat image using organization name in pull tag, then add custom tag to the iamge
echo -e "\n\n# Pull OWASP WebGoat image using organization name in pull tag, then add custom tag to the iamge"
docker pull webgoat/webgoat
docker tag webgoat/webgoat special-webgoat
docker images | grep webgoat
docker image rm special-webgoat

read -p "Press Enter to continue to the next step..."

# Build uvicorn-test container via dockerfile and verify server started w/o error, via:
echo -e "\n\n# Build uvicorn-test container via dockerfile and verify server started w/o error, via:"
docker build -t uvicorn-test ./
docker run -d --name uvicorn-test -p 8081:8081 uvicorn-test
docker logs uvicorn-test
curl http://localhost:8081/

read -p "Press Enter to continue to the next step..."

# List docker volumes on local machine
echo -e "\n\n# List docker volumes on local machine"
docker volume ls

read -p "Press Enter to continue to the next step..."

# Remove un-used volumes and list again
echo -e "\n\n# Remove un-used volumes and list again"
docker volume prune
docker volume ls

read -p "Press Enter to continue to the next step..."

# Update linux apt repos and install Docker Compose
echo -e "\n\n# Update linux apt repos and install Docker Compose"
sudo apt-get update
sudo apt-get install -y docker-compose-plugin
docker compose version

read -p "Press Enter to continue to the next step..."

# Start my FastAPI over uvicorn demo app w/ live-reloading in isolated env w/ Docker Compose
echo -e "\n\n# Start my FastAPI over uvicorn demo app w/ live-reloading in isolated env w/ Docker Compose"
docker rm -f uvicorn-test
docker compose watch

read -p "Press Enter to continue to the next step..."

# Clean up again
echo -e "\n\n# Clean up again"
docker compose down -v 2>/dev/null
docker rm -f $(docker ps -aq) 2>/dev/null
docker rmi -f $(docker images -q) 2>/dev/null
docker system prune -af --volumes

read -p "Press Enter to continue to the next step..."

# Verify cleanup
echo -e "\n\n# Verify cleanup"
docker ps -a          # should be empty
docker images         # should be empty
docker volume ls      # should be empty
docker network ls     # only the 3 defaults: bridge, host, none

echo -e "\n\nScript complete! Docker review is over!"