FROM ruby:2.3.0-slim

WORKDIR /app/kuroko

EXPOSE 3000
RUN groupadd -r app && useradd -r -g app app

RUN apt-get update \
    && apt-get install -y \
       build-essential \
       mysql-client \
       libmysqlclient-dev \
       software-properties-common \
    && add-apt-repository -y ppa:chris-lea/node.js \
    && echo "deb http://archive.ubuntu.com/ubuntu precise universe" >> /etc/apt/sources.list \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*


COPY Gemfile      /app/kuroko/Gemfile
COPY Gemfile.lock /app/kuroko/Gemfile.lock
RUN bundle install -j4

COPY . /app/kuroko
RUN RAILS_ENV=production bundle exec rake assets:precompile \
  && chown -R app:app /app/kuroko

USER app
CMD ["./bin/start_server.sh"]
