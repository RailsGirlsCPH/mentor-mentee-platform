FROM ruby:2.6.5


RUN apt-get update \
    && apt-get install -y --no-install-recommends nodejs libpq-dev libxslt1-dev libffi-dev postgresql-client-common postgresql-client

WORKDIR /app

COPY Gemfile* ./
RUN bundle install

COPY . .

CMD ./init_script.sh



