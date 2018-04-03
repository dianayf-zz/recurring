#!/bin/bash --login
bundle check || bundle install
yarn install

#entrypoint for docker
bundle exec "$@"
