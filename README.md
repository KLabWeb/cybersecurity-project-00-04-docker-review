# Phase 0: Docker & Docker Compose Review

This is review work which as I did as a Docker refresher, while starting my cybersecurity studies, in Phase 0, the setup & review phase to the study plan.

## Commands Script

My [command script](https://github.com/KLabWeb/cybersecurity-project-00-04-docker-review/blob/main/containerize-practice-executable.sh) is all the commands I was running locally while reviewing image pulls, container execution, container run commands, viewing metadata on containers, managing containers and images, containers in interactive mode, bridges, networks, volumes, and other basic Docker features. 

I recorded me running this script on a test environment and recorded my terminal, live, with asciinema. I then put the recording of the script and all the steps that happen in it on a quick static site on Digital Ocean. [View the script execution here!!!](https://cyb-project-00-04-docker-review-zh7g6.ondigitalocean.app/)

## Dockerfile

My [Dockerfile](https://github.com/KLabWeb/cybersecurity-project-00-04-docker-review/blob/main/Dockerfile) is a playground file where I use slim Python 3.14 as the base image, then set my image to start by running a Uvicorn instance which pulls in its src files from a local FastAPI app to serve a very simple web API. I play around with random instructions here also, like RUN, ADD, and VOLUME.

## Docker Compose

My [Docker Compose](https://github.com/KLabWeb/cybersecurity-project-00-04-docker-review/blob/main/docker-compose.yaml) file is built to allow live-reloading of my FastAPI app every time a change in my src files is detected. This is done using the watch command, where I set my rules for watch to sync+restart and rebuild on local filechange.

## Related

- [Portfolio](https://github.com/KLabWeb/cybersecurity-portfolio) — the work I am doing from what I am learning
- [Study Plan](https://github.com/KLabWeb/cybersecurity-study-plan) — the full curriculum
- [Study Notes](https://github.com/KLabWeb/cybersecurity-notes) — what I'm learning as I work through it
- [Study Tracker](https://github.com/KLabWeb/cybersecurity-study-tracker) — what I'm doing, for how long, and when
