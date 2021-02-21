FROM node:14-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN groupadd -r rocketchat \
    &&  useradd -r -g rocketchat rocketchat \
    &&  mkdir -p /app/uploads \
    &&  chown rocketchat.rocketchat /app/uploads


# gpg: key 4FD08014: public key "Rocket.Chat Buildmaster <buildmaster@rocket.chat>" imported
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 0E163286C20D07B9787EBE9FD7F9D0414FD08104

RUN echo "deb [check-valid-until=no] http://cdn-fastly.deb.debian.org/debian jessie main" > /etc/apt/sources.list.d/jessie.list

RUN sed -i '/deb http:\/\/deb.debian.org\/debian jessie-updates main/d' /etc/apt/sources.list
RUN apt-get -o Acquire::Check-Valid-Until=false update

RUN apt-get update && \
    apt-get install -y --no-install-recommends unzip build-essential python make g++ apt-utils \
    apt-get install -y gcc python-dev libkrb5-dev && \
    apt-get install git -y && \
    apt-get install python3-pip -y && \
    apt-get install awscli -y && \
    pip3 install --upgrade pip && \
    pip3 install --upgrade virtualenv && \
    pip3 install pywinrm[kerberos] && \
    pip3 install pywinrm && \
    pip3 install ansible
