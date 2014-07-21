FROM ubuntu:14.04

ENV HOME /root

ADD docker/contestrus/base.sh /base.sh
RUN /base.sh

ADD docker/contestrus/ruby.sh /ruby.sh
RUN /ruby.sh

RUN docker/contestrus/provision.sh /provision.sh
RUN /provision.sh
