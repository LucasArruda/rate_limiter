FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /rate_limiter
WORKDIR /rate_limiter
COPY Gemfile /rate_limiter/Gemfile
COPY Gemfile.lock /rate_limiter/Gemfile.lock
RUN bundle install
COPY . /rate_limiter

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]