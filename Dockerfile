FROM ubuntu:18.04 

#ENV DEBIAN_FRONTEND noninteractive

RUN apt update -y \
        && apt upgrade -y \
	&& apt install -y curl wget sudo apt-utils gnupg \
	&& curl -s http://download.mono-project.com/repo/xamarin.gpg | sudo apt-key add - \
	&& echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/xamarin.list \
	&& apt-get update \
	&& apt-get -y install mono-complete libopus-dev ffmpeg

RUN useradd -m -d /home/container container

USER container
ENV HOME /home/container
ENV TERM=xterm
WORKDIR /home/container

#RUN wget -O linuxgsm.sh https://linuxgsm.sh \
#	&& chmod +x linuxgsm.sh \
#	&& bash linuxgsm.sh arma3servr
#USER root

#RUN mkdir -p lgsm/config-lgsm/arma3server
#RUN echo "steamuser='' \n steampass=''" > \
#	lgsm/config-lgsm/arma3server/common.cfg 

#RUN chown container:container \
#	/home/container
#RUN chmod -R 777 \
#	/home/container 

#USER container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
