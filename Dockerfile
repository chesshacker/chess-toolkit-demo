FROM ruby:latest
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /usr/src/app
WORKDIR /usr/src/app
RUN apt-get install -y git autoconf libtool pkg-config check bison flex
RUN cd /usr/src && \
    git clone https://github.com/steveortiz/chess_toolkit.git && \
    cd chess_toolkit && ./configure && make && make install && \
    cd examples/ruby_gem && gem install rake-compiler && \
    rake gem && cd pkg && gem install chess_toolkit-0.0.0.gem
ADD Gemfile /usr/src/app/Gemfile
ADD Gemfile.lock /usr/src/app/Gemfile.lock
RUN bundle install
CMD ./bin/start
