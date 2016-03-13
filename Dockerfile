FROM maven:3-jdk-8

MAINTAINER Per-Gustaf Stenberg <per-gustaf.stenberg@dataductus.se>

### Install Curl and Zip - required for installation using script
RUN apt-get update && apt-get install -y curl zip apt-transport-https ca-certificates

## Install Docker - mount /var/run/docker.sock in order to use the host docker-engine
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-engine

### Add VsoAgent user
RUN useradd -m vsoagent && gpasswd -a vsoagent docker && gpasswd -a vsoagent users


### Add maven settings and change premission on .m2 folder
COPY settings.xml /home/vsoagent/.m2/settings.xml
RUN chown -R vsoagent:vsoagent /home/vsoagent/.m2


### Change user and workdir
USER vsoagent
WORKDIR /home/vsoagent


### Install VSO-Agent using bash and curl
RUN curl -skSL http://aka.ms/xplatagent | bash

### Run agent, this requires docker container to be started in interactive mode
ENTRYPOINT ["bash","./run.sh"]
