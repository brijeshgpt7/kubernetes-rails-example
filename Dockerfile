FROM ruby:2.7.0

RUN curl https://deb.nodesource.com/setup_12.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y nodejs yarn postgresql-client

RUN mkdir /app
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install
COPY . .
CMD ["rails", "webpacker:install"]
CMD ['bundle', 'exec', 'rake', 'assets:precompile']

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
