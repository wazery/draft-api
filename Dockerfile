FROM ruby:latest
MAINTAINER Islam Wazery <wazery@ubuntu.com>

ENV HOME /home/rails/api

# Install PGsql dependencies and js engine
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR $HOME

# Install gems
ADD Gemfile* $HOME/
RUN bundle install

# Add the app code
ADD . $HOME

# Default command
ENTRYPOINT ["bundle", "exec"]
CMD ["rails", "server", "--binding", "0.0.0.0", "-e", "production"]
