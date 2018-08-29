FROM ubuntu:16.04 

RUN apt-get update -y \
	&& apt-get upgrade -y

RUN echo "postfix postfix/main_mailer_type string 'Local only'" \
	| debconf-set-selections 

RUN dpkg --add-architecture i386; \
	apt-get update -y; \
	apt-get install -y mailutils \
	postfix \
	curl \
	wget \
	file \
	bzip2 \
	gzip \
	unzip \
	bsdmainutils \
	python \
	util-linux \
	ca-certificates \
	binutils \
	bc \
	jq \
	tmux \
	lib32gcc1 \
	libstdc++6 \
	libstdc++6:i386

RUN useradd -d /home/container -m container

USER container
ENV USER container
ENV HOME /home/container
ENV TERM=xterm
WORKDIR /home/container

RUN wget -O linuxgsm.sh https://linuxgsm.sh \
	&& chmod +x linuxgsm.sh \
	&& bash linuxgsm.sh arma3server

USER root

RUN mkdir -p lgsm/config-lgsm/arma3server
RUN echo "steamuser='_dave_1987' \n steampass='IIhhII11gg'" > \
	lgsm/config-lgsm/arma3server/common.cfg 

RUN chown container:container \
	/home/container
RUN chmod -R 777 \
	/home/container 

USER container 

RUN ./arma3server auto-install

COPY ./entrypoint.sh /entrypoint.sh
#CMD ["/bin/bash", "/entrypoint.sh"]
