FROM ruby:2.5.0
RUN apt-get update -qq && apt-get install -y \
    build-essential libpq-dev
    
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && apt-get update && apt-get install -y nodejs 

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list 

RUN apt-get update && apt-get install -y yarn

RUN mkdir /app

WORKDIR /app
COPY ./Gemfile* /app/
RUN bundle install

COPY . /app