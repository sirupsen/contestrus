FROM ubuntu
RUN apt-get install -y wget
RUN wget -O - http://go.googlecode.com/files/go1.1.2.linux-amd64.tar.gz | tar xzf - -C /usr/local/
RUN ln -s /usr/local/go/bin/go /usr/local/bin/go
RUN ln -s /usr/local/go/bin/gofmt /usr/local/bin/gofmt
RUN ln -s /usr/local/go/bin/godoc /usr/local/bin/godoc