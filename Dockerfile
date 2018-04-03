FROM ruby:2.5.0
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN apt-get update 
RUN apt-get install -y nodejs yarn

RUN mkdir /recurring
WORKDIR /recurring

ENV BUNDLE_PATH /recurring/.gems
ENV GEM_HOME /recurring/.gems
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
RUN apt-get install wget ca-certificates
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install postgresql-client-9.4 -y

ENTRYPOINT ["./start-bundle-exec.sh"]
