FROM ubuntu:16.04
MAINTAINER Islam Wazery <wazery@ubuntu.com>

# Update the repository
RUN apt-get update && \
    apt-get install -y wget sudo dialog net-tools git build-essential rails ruby nginx && \
    apt-get clean &&  rm -rf /var/lib/apt/lists/*

RUN gem install sass && mkdir -p /home/draft-api

COPY Gemfile /home/draft-api
COPY Gemfile.lock /home/draft-api

WORKDIR /home/draft-api

# Install Prerequisites
RUN bundle install
RUN rake db:migrate

ADD . /home/draft-api

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 3000

CMD service nginx start
