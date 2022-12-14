FROM ruby:3.1.2 as base

# set some default ENV values for the image
ENV RAILS_LOG_TO_STDOUT 1
ENV RAILS_SERVE_STATIC_FILES 1
# set the app directory var
ENV APP_HOME /home/app
WORKDIR $APP_HOME

ARG NODE_MAJOR_VERSION=14
RUN curl -sL https://deb.nodesource.com/setup_${NODE_MAJOR_VERSION}.x | bash - \
  && apt-get update -qq \
  && apt-get install -y --no-install-recommends \
  build-essential \
  curl \
  postgresql-client \
  dumb-init \
  git \
  libssl-dev \
  libxslt-dev \
  nodejs \
  openssh-client \
  unzip \
  zlib1g-dev \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean

# install specific bundler version
ARG BUNDLER_VERSION=2.3.7
ARG BUNDLE_DIR=/usr/local/bundle
RUN gem install bundler -v "${BUNDLER_VERSION}"

# install gems
COPY Gemfile* ./
RUN bundle config --local without "development test"
RUN bundle config --local path ${BUNDLE_DIR}
RUN bundle install
# copy code
COPY . .

ARG RAILS_ENV=production
ENV RAILS_ENV ${RAILS_ENV}

EXPOSE 3000
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD [ "bin/rails", "s", "-u", "Puma", "-b", "0.0.0.0", "-p", "3000" ]


# describe in production enviroment

FROM base as production

ARG BUNDLER_VERSION=2.3.7
ARG BUNDLE_DIR=/usr/local/bundle

COPY --from=base  ${BUNDLE_DIR} ${BUNDLE_DIR}
COPY Gemfile* ./

RUN gem install bundler -v "${BUNDLER_VERSION}"
RUN bundle config --local without "development test"
RUN bundle config --local path ${BUNDLE_DIR}
RUN bundle install

COPY --from=base /home/app/public /home/app/public
RUN bundle exec rake assets:precompile

