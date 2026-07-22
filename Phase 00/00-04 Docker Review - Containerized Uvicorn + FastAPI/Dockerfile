# Practice dockerfile as part of cybersecurity studies review intro
# to build this image: run
#    docker image build -t uvicorn-test ./

# Specify base image to extend  & app dir
FROM python:3.14-slim
WORKDIR /usr/local/app

 # Install py dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir --root-user-action=ignore -r requirements.txt

# Copy in source code to container & expose app port 
COPY src ./src
EXPOSE 8080

# Verify Src added via
# docker run --rm -it uvicorn-test /bin/bash
# ls -R

# Set container to run as non-root
RUN useradd test-user
USER test-user

# Verify now test-user
# docker run --rm -it uvicorn-test whoami
# then restore to root
USER root

# Set default command to start univorn server when container starts
# Plus look for app.main for app to serve, set default interface, and set listening port
CMD ["uvicorn", "main:app", "--app-dir", "src", "--host", "0.0.0.0", "--port", "8081"]

# Set custom env var
ENV APP_ENV=development

# Add metadata to image
LABEL version="0.3"

# Add assets to container with auto-extraction from tar.gz
# Add file from remote server to container
ADD ./test-assets/test.tar.gz ./src/assets
ADD https://github.com/KLabWeb/cybersecurity-study-plan/blob/main/Study_Plan_-_Final.pdf ./src/assets

# Verify assets added via
# docker run --rm -it uvicorn-test /bin/bash
# ls -R

# Create persistent image volume that exists even past container delete
COPY ./test-assets/persistent-file.txt /usr/local/app/persistent-storage/persistent-file.txt
VOLUME ./persistent-storage

# Verify file added via
# docker run --rm -it uvicorn-test /bin/bash
# ls -R ./persistent-storage