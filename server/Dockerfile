FROM ruby:2.6.5


RUN apt-get update \
    && apt-get install -y --no-install-recommends nodejs libpq-dev postgresql-client

WORKDIR /app

COPY Gemfile* ./
RUN gem install bundler -v "$(grep -A 1 "BUNDLED WITH" Gemfile.lock | tail -n 1)"
RUN bundle install

COPY . .

CMD ./init_script.sh
