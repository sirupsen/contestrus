FROM ubuntu:14.04

ENV HOME /root

ADD docker/contestrus/base.sh /base.sh
RUN /base.sh

ADD docker/contestrus/ruby.sh /ruby.sh
RUN /ruby.sh

ADD . /app
RUN /app/docker/contestrus/provision.sh
