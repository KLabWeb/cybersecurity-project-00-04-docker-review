# Practice dockerfile as part of cybersecurity studies review intro

# Specify base image to extend  & app dir
FROM python:3.14-slim
WORKDIR /usr/local/app

 # Install py dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir --root-user-action=ignore -r requirements.txt

# Copy in source code & expose app port 
COPY src ./src
EXPOSE 8080

# Set container to run as non-root
RUN useradd test-user
USER test-user

# Set default command to start univorn server when container starts
# Plus look for app.main for app to serve, set default interface, and set listening port
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]

# Set custom env var
ENV APP_ENV=development