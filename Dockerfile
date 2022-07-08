FROM ruby:3.1.2

WORKDIR /app

COPY . /app

RUN bundle install
