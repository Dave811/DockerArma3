FROM ubuntu:18.04 

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y \
	&& apt-get upgrade -y

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
