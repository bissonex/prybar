FROM ubuntu:bionic

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
	build-essential \
	wget \
	golang \
	python-dev \
	python3-dev \
	liblua5.2-dev \
	ruby2.5-dev \
	tcl-dev \
	libnspr4-dev \
	libffi-dev \
	expect \
	nodejs

RUN wget \
	http://launchpadlibrarian.net/309343864/libmozjs185-dev_1.8.5-1.0.0+dfsg-7_amd64.deb && \
	wget http://launchpadlibrarian.net/309343863/libmozjs185-1.0_1.8.5-1.0.0+dfsg-7_amd64.deb && \
	dpkg -i libmozjs185*.deb && rm libmozjs185*.deb

RUN mkdir -p /gocode/src/github.com/replit/prybar

ENV GOPATH=/gocode
ADD . /gocode/src/github.com/replit/prybar
WORKDIR /gocode/src/github.com/replit/prybar

RUN which node

RUN make prybar-python2 prybar-python3 prybar-ruby prybar-lua prybar-spidermonkey prybar-nodejs
RUN make test

ENV LC_ALL=C.UTF-8

CMD bash
