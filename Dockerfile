#Command to build a docker image from this dockerfile. The '.' in the command means the below line assumes
#you have already navigated into the directory that has this Dockerfile
##########
#Docker build -t [image name] .
##########

#This is a command to build from a 'template' image. In this case a CentOS7 image. This is by far the easiest
#way to define what OS architecture your image contains. CentOS7 is a RHEL7 linux OS.
FROM centos:7

#This command exposes a defined port for external traffic.
EXPOSE 8000

#These commands set global environmental variables. Another example would be setting your $PATH variable.
ENV LC_ALL=en_US.utf8
ENV LANG=en_US.utf8

#yum is a linux based package manager. The -y command simply says 'yes' to any prompts the yum command makes
RUN yum -y install epel-release
RUN yum -y install python36
RUN yum -y install python3-pip

#This is a pip command for installing a specific module version
RUN pip3 install uvicorn==0.16.0
RUN yum -y install python-psycopg2.x86_64

RUN mkdir /home/work

COPY Hello.py /home/work

WORKDIR /home/work

RUN echo "=======Encoding check========="
RUN echo "LC_ALL is set as: $LC_ALL"
RUN echo "LANG is set as: $LANG"

#Docker run --name ewdolTestAPI -d docker-registry.dev.simventions.com:5000/dockerhub/ewdol/api:latest uvicorn EWDOL_API_Core:api
CMD ["python","Hello.py"]