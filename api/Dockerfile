FROM ruby:3.2-alpine

RUN apk add --no-cache build-base postgresql-dev tzdata git bash yaml-dev curl

WORKDIR /app
ENV BUNDLE_PATH=/usr/local/bundle

# Install gems first for better caching
COPY Gemfile Gemfile.lock* /app/
RUN bundle install

# Copy app code
COPY . /app

EXPOSE 3000

# Single source of truth for boot
ENTRYPOINT ["bash", "-lc", "./entrypoint.sh"]
