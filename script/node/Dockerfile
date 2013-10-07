FROM ubuntu

ENV NODE_VERSION v0.10.20
ENV NODE_PACKAGE node-$NODE_VERSION-linux-x64

RUN apt-get update
RUN apt-get install -y wget
RUN wget -O - http://nodejs.org/dist/$NODE_VERSION/$NODE_PACKAGE.tar.gz | tar xzf - -C /usr/local
RUN ln -s /usr/local/$NODE_PACKAGE/bin/node /usr/local/bin/node
