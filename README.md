# Phase 0: Docker & Docker Compose Review

This is review work which as I did as a Docker refresher, while starting my cybersecurity studies, in Phase 0, the setup & review phase to the study plan.

## Commands Script
My [command script]() is all the commands I was running locally while reviewing image pulls, container execution, container run commands, viewing metadata on containers, managing containers and images, containers in interactive mode, bridges, networks, volumes, and other basic Docker features

## Dockerfile
My [Dockerfile]() is a playground file where I use slim Python 3.14 as the base image, the set it to start by running a Uvicorn instance which pulls in its src files from a local FastAPI app to serve a very simple web API. I play around with random instructions here also, like RUN, ADD, and VOLUME.

## Docker Compose
My [docker-compose.yaml] file is built to allow live-reloading of my app every time a change in my src files (my FastAPI app) is detected. This is done using the watch command, where I set my rules for watch to sync+restart and rebuild on filechange.

## Related

- [Portfolio](https://github.com/KLabWeb/cybersecurity-portfolio) — the work I am doing from what I am learning
- [Study Plan](https://github.com/KLabWeb/cybersecurity-study-plan) — the full curriculum
- [Study Notes](https://github.com/KLabWeb/cybersecurity-notes) — what I'm learning as I work through it
- [Study Tracker](https://github.com/KLabWeb/cybersecurity-study-tracker) — what I'm doing, for how long, and when
