FROM ruby:3.3.6

RUN mkdir /app

WORKDIR /app

COPY Gemfile /app/Gemfile

COPY Gemfile.lock /app/Gemfile.lock

RUN gem update --system && \
  bundle install

COPY . /app

CMD ["rails", "server", "-b", "0.0.0.0"]
