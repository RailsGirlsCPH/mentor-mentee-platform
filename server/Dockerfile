
FROM ruby:2.6.5

EXPOSE 3000


RUN apt-get update \
    #&& apt-get install -y --no-install-recommends \
    #    postgresql-client \
    && apt-get install -y --no-install-recommends nodejs \
    && apt-get install -y --no-install-recommends libpq-dev
    #&& rm -rf /var/lib/apt/lists/* 



WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install
COPY . .

CMD ["rails", "server"]