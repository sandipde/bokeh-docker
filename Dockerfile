############################################################
# Dockerfile to build Python WSGI Application Containers
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
#FROM ubuntu
FROM docker/whalesay:latest
# File Author / Maintainer
MAINTAINER Sandip De

# Add the application resources URL
RUN echo "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc) main universe" >> /etc/apt/sources.list

# Update the sources list
RUN apt-get -y update

# Install basic applications
RUN apt-get install -y tar git curl nano wget dialog net-tools build-essential

# Install Python and Basic Python Tools
RUN apt-get install -y python python-dev python-distribute python-pip

# Copy the application folder inside the container
ADD /my_application /my_application

# Get pip to download and install requirements:
RUN pip install -r /my_application/requirements.txt

# Expose ports
EXPOSE 5006

# Set the default directory where CMD will execute
WORKDIR /my_application

# Set the default command to execute    
# when creating a new container
# i.e. using CherryPy to serve the application
CMD bokeh serve server.py
