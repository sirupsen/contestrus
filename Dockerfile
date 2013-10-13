FROM greglearns/ruby
RUN git clone https://github.com/Sirupsen/contestrus.git
RUN cd contestrus
RUN script/prepare
