FROM node:14-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN echo "deb [check-valid-until=no] http://cdn-fastly.deb.debian.org/debian jessie main" > /etc/apt/sources.list.d/jessie.list

RUN sed -i '/deb http:\/\/deb.debian.org\/debian jessie-updates main/d' /etc/apt/sources.list

RUN apt-get -o Acquire::Check-Valid-Until=false update

RUN apt-get update 

RUN apt-get install -y unzip zip build-essential python make g++ apt-utils 

RUN apt-get install -y gcc python-dev libkrb5-dev git python3-pip awscli
    
RUN pip3 install --upgrade pip && \
    pip3 install --upgrade virtualenv && \
    pip3 install pywinrm[kerberos] && \
    pip3 install pywinrm && \
    pip3 install ansible
