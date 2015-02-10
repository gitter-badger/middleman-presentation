FROM ruby:2.2
MAINTAINER Max Meyer <dev@fedux.org>

RUN apt-get update -y
RUN apt-get install -y nodejs
# RUN npm install -g bower

RUN gem install middleman-presentation -v 0.16.0.rc1
RUN gem install therubyracer

VOLUME /var/tmp/build
WORKDIR /var/tmp/build

# ENTRYPOINT ["/usr/bin/middleman-presentation"]
