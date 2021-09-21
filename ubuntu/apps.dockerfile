
ARG BASE
FROM ${BASE}

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y

RUN apt-get install -y openssh-server ;\
    echo "X11UseLocalHost no" >> /etc/ssh/sshd_config

RUN apt-get install -y fonts-hack-ttf
RUN apt-get install -y emacs


RUN apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*


