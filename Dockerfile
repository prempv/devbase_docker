FROM ubuntu:latest
LABEL maintainer="prempv"

ARG USER_NME="prempv_docker"
ARG USER_PWD

ENV USER_NAME $USER_NME
ENV USER_PASSWORD $USER_PWD
ENV CONTAINER_IMAGE_VER=v1.0.0

RUN echo $USER_NAME
RUN echo $USER_PASSWORD
RUN echo $CONTAINER_IMAGE_VER


RUN apt-get update -y && \
	apt-get install -y sudo \
	build-essential \
	vim \
	man \
	curl \
	git \
	wget \
	zsh \
	fonts-powerline

#*************** Python & Anaconda Install **********************
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-x86_64.sh -O ~/anaconda.sh && \
	/bin/bash ~/anaconda.sh -b -p /opt/conda && \
	rm ~/anaconda.sh && \
	ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh

#*************** USER MGMT **********************
# # add a user (--disabled-password: the user won't be able to use the account until the password is set)
RUN adduser --disabled-password --shell /bin/zsh --home /home/$USER_NAME --gecos "User" $USER_NAME

# # update the password
RUN echo "${USER_NAME}:${USER_PASSWORD}" | chpasswd && usermod -aG sudo $USER_NAME

# the user we're applying this too (otherwise it most likely install for root)
USER $USER_NAME

#*************** ZSH **********************
# terminal colors & theme with xterm
ENV TERM xterm
ENV ZSH_THEME pygmalion

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

# Custom ZSHRC file
COPY zshrc_for_docker.sh /home/$USER_NAME/.zshrc
#RUN chmod 777 /home/$USER_NAME/.zshrc

# Syntax highlighting plugin install
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


# start zsh
#CMD [ "zsh && cd ~" ]




