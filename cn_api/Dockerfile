FROM ruby:2.7.1
RUN apt-get update -qq && apt-get install -y postgresql-client
RUN mkdir /cn_api
WORKDIR /cn_api
COPY Gemfile /cn_api/Gemfile
COPY Gemfile.lock /cn_api/Gemfile.lock
RUN mkdir -p /cn_api/log && touch /cn_api/log/development.log
RUN gem install bundler
RUN bundle install
COPY . /cn_api
RUN gem install foreman