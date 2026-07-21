#!/bin/bash

# Provisioning script for local docker WebGoat install via containers for WebGoat
# Plus nginx & postgres, for further Docker review

# Get docker version
docker version

# Pull test image & verify pull
docker pull nginx:latest
docker image ls

# Start container w/ custom name & verify running
docker run -d --name nginx-test nginx 
docker ps
ps -ef | grep nginx

# Attach container to terminal
echo "Enter container ID then press enter to attach to container"
read $container_id
docker attach $container_id
docker stop $container_id

# Run container w/ env var & verify var set
docker pull mysql
docker run -d --name mysql-test --env MYSQL_RANDOM_ROOT_PASSWORD=yes mysql
docker ps
docker logs mysql-test 2>&1 | grep "GENERATED ROOT PASSWORD"

# Pull and run older version mysql and latest ver mysql in diff containers
docker pull mysql:8.4
docker run -d --name mysql-old  --env MYSQL_RANDOM_ROOT_PASSWORD=yes mysql:8.4
docker ps

# Via image details for mysql
docker inspect mysql

#Stop, pause, and kill containers
docker stop mysql-test
docker pause mysql-old
docker ps
docker kill mysql-old
docker ps

# Remove mysql 8.4 container & image
docker  ps -a
docker rm mysql-old
docker container ps -a

# List images & remove mysql 8.4 image
docker image ls
docker rmi mysql:8.4
docker image ls

# Via container top processes, HW usage stats, metadata, & logs
docker top nginx-test
docker stats nginx-test
docker inspect nginx-test
docker logs nginx-test

# Run nginx container in interactive mode
docker stop nginx-test
docker rm nginx-test
docker run --name nginx-test -it nginx bash
ls
exit
docker ps

# Start container in standard mode, then start in interactive using commands
# Not how I can now exit bash without container stopping, unlike when starting interactive
docker rm nginx-test
docker run -d --name nginx-test nginx
docker exec -it nginx-test bash
ls
exit
docker ps

# Start nginx with bridge between ports 8080 on host and 80 on container & verify port mapping
docker stop nginx-test
docker rm nginx-test
docker run -d --name nginx-test -p 8080:80 nginx
docker port nginx-test

# Explore networks, then create network and connect nginx-test to it, verify, then disconnect nginx, and remove network in two ways
docker network ls
docker network inspect bridge
docker network create test-network
docker network connect nginx-test
docker network connect test-network nginx-test
docker network ls
docker network inspect test-network | grep nginx-test
docker network disconnect test-network nginx-test
docker network inspect test-network | grep nginx-test
docker prune test-network
docker network ls
docker network create test-network
docker network rm test-network
docker network ls

# Remove all stopped containers, networks w/ no containers, dangling images, & build cache
docker ps -a
docker image ls
docker system prune
docker ps -a

# View history for mysql image
docker history mysql

# Pull OWASP WebGoat image using organization name in pull tag, then add custom tag to the iamge
docker pull webgoat/webgoat
docker tag webgoat/webgoat special-webgoat
docker images | grep webgoat