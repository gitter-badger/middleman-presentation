FROM ruby:2.2
MAINTAINER Max Meyer <dev@fedux.org>

RUN gem install therubyracer
RUN gem install middleman-presentation -v 0.16.0.rc1

VOLUME /var/tmp/build
WORKDIR /var/tmp/build

ENTRYPOINT ["/usr/bin/middleman-presentation"]
