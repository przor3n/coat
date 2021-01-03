FROM python:3.8-slim

# create container user

# set root
USER root

# run update and install commands
RUN apt-get update && apt-get upgrade && apt-get -y install build-essential

# move code and go to it.
COPY . /app
WORKDIR /app

# run container stuff
RUN pip install -r requirements_dev.txt

# make sure container user can do stuff and switch to that user

# run some commans
