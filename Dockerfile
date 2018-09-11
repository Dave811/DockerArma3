FROM ubuntu:18.04 

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y \
	&& apt-get upgrade -y \
	&& apt install -y sudo \
	&& apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
	&& echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list \
	&& apt update -y \
	&& apt install -y mono-complete libopus-dev ffmpeg unzip tar wget xz-utils

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
