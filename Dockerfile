# Image base
FROM ruby:slim

# Minim dependencies system
RUN apt-get update -qq && \
    apt-get install -y build-essential sqlite libsqlite3-dev

ENV PROJECT docker-live-reload

# Create project folder
RUN mkdir /$PROJECT

# Work in project folder
WORKDIR /$PROJECT

# Add file for apps
ADD Gemfile /$PROJECT/Gemfile
ADD Gemfile.lock /$PROJECT/Gemfile.lock

# Execute gem install
RUN bundle install

# Add project to container
ADD . /$PROJECT
