FROM ruby:3.1.2 as base

# set some default ENV values for the image
ENV BUNDLE_PATH /bundle
ENV RAILS_LOG_TO_STDOUT 1
ENV RAILS_SERVE_STATIC_FILES 1

# set the app directory var
ENV APP_HOME /home/app
WORKDIR $APP_HOME

RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends \
  build-essential \
  curl \
  postgresql-client \
  git \
  libssl-dev \
  libxslt-dev \
  nodejs \
  openssh-client \
  unzip \
  zlib1g-dev \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean

# add and verify github host fingerprint
# (necessary if you're installing gems from github)
RUN ssh-keyscan -t rsa github.com \
  | tee /root/.ssh/known_hosts \
  | ssh-keygen -lf - \
  | grep 'SHA256:nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8'

# install specific bundler version
ARG BUNDLER_VERSION=2.0.2
RUN gem install bundler -v "${BUNDLER_VERSION}"

# install gems
COPY Gemfile* ./
RUN bundle install
# copy code
COPY . .

ARG RAILS_ENV=production
ENV RAILS_ENV ${RAILS_ENV}

RUN bundle exec rake assets:precompile

EXPOSE 3000

CMD [ "bin/rails", "s", "-u", "Puma", "-b", "0.0.0.0", "-p", "3000" ]


