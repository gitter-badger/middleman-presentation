FROM ruby:2.2
MAINTAINER Max Meyer <dev@fedux.org>

# ENV http_proxy http://172.17.42.1:3128
# ENV https_proxy https://172.17.42.1:3128

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y
RUN apt-get install -y nodejs
RUN apt-get install -y npm

# RUN npm config set proxy http://172.17.42.1:3128
# RUN npm config set https-proxy http://172.17.42.1:3128
RUN npm install -g bower

RUN gem install therubyracer
RUN gem install puma

RUN gem install middleman-presentation -v 0.16.0
RUN gem install therubyracer

VOLUME /var/tmp/build
WORKDIR /var/tmp/build

EXPOSE 9292

CMD ["/usr/local/bundle/bin/middleman-presentation"]
