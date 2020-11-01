FROM ruby:2.6.5


RUN apt-get update \
    && apt-get install -y --no-install-recommends nodejs libpq-dev postgresql-client

WORKDIR /app

COPY Gemfile* ./
RUN bundle install

COPY . .

CMD ./init_script.sh
