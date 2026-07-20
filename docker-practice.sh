#!/bin/bash

# provisioning script for local docker WebGoat install via containers for WebGoat
# plus nginx & postgres, for further Docker review

# get docker version
docker version

# pull test image & verify pull
docker pull nginx:latest
docker image ls

# start container w/ custom name & verify running
docker run -d --name nginx-test nginx 
docker ps
ps -ef | grep nginx

# attach container to terminal
echo "Enter container ID then press enter to attach to container"
read $container_id
docker attach $container_id
docker stop $container_id

# run container w/ env var & verify var set
docker pull mysql
docker run -d --name mysql-test --env MYSQL_RANDOM_ROOT_PASSWORD=yes mysql
docker ps
docker logs mysql-test 2>&1 | grep "GENERATED ROOT PASSWORD"

# pull and run older version mysql and latest ver mysql in diff containers
docker pull mysql:8.4
docker run -d --name mysql-old  --env MYSQL_RANDOM_ROOT_PASSWORD=yes mysql:8.4
docker ps

# via image details for mysql
docker inspect mysql

#stop, pause, and kill containers
docker stop mysql-test
docker pause mysql-old
docker ps
docker kill mysql-old
docker ps

# remove mysql 8.4 container & image
docker  ps -a
docker rm mysql-old
docker container ps -a

# list images & remove mysql 8.4 image
docker image ls
docker rmi mysql:8.4
docker image ls

# via container top processes, HW usage stats, metadata, & logs
docker top nginx-test
docker stats nginx-test
docker inspect nginx-test
docker logs nginx-test

# run nginx container in interactive mode
docker stop nginx-test
docker rm nginx-test
docker run --name nginx-test -it nginx bash
ls
exit
docker ps

# start container in standard mode, then start in interactive using commands
# not how I can now exit bash without container stopping, unlike when starting interactive
docker rm nginx-test
docker run -d --name nginx-test nginx
docker exec -it nginx-test bash
ls
exit
docker ps

# start nginx with bridge between ports 8080 on host and 80 on container & verify port mapping
docker stop nginx-test
docker rm nginx-test
docker run -d --name nginx-test -p 8080:80 nginx
docker port nginx-test

# explore networks, then create network and connect nginx-test to it, verify, then disconnect nginx, and remove network in two ways
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

# remove all stopped containers, networks w/ no containers, dangling images, & build cache
docker ps -a
docker image ls
docker system prune
docker ps -a

# view history for mysql image
docker history mysql

# pull OWASP WebGoat image using organization name in pull tag, then add custom tag to the iamge
docker pull webgoat/webgoat
docker tag webgoat/webgoat special-webgoat
docker images | grep webgoat