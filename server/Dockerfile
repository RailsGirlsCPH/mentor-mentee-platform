
FROM ruby:2.6.5

EXPOSE 3000


RUN apt-get update \
    && apt-get install -y --no-install-recommends nodejs \
    && apt-get install -y --no-install-recommends libpq-dev



WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install
COPY . .

CMD ["rails", "server"]