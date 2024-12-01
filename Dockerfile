# iamge
FROM ubuntu:22.04
LABEL MAINTAINER="Mahmoud Khaled, eng.mk@msn.com"

# set time/language
ENV TZ=Europe/Kiev
ENV LANG C.UTF-8
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# update image
RUN apt-get -qq update \
	&& apt-get -qq install -y --no-install-recommends apt-utils \
	&& apt-get -qq -y upgrade

# install required libs/tools
RUN apt-get -qq install -y wget git unzip build-essential libcpprest-dev clinfo oclgrind cmake

# install pFaces (1.1.1 demo)
RUN mkdir pfaces \
	&& cd pfaces \
	&& wget https://github.com/parallall/pFaces/releases/download/Release_1.3.0d/pFaces-1.3.0-Ubuntu22.04.zip \
	&& unzip pFaces-1.1.1-Ubuntu18.04.zip
RUN cd /pfaces && sh install.sh
