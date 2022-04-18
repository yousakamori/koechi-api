FROM ruby:3.0.4-alpine3.14

ENV RUNTIME_PACKAGES="linux-headers libxml2-dev make gcc openssh libc-dev nodejs tzdata postgresql-dev postgresql git imagemagick shared-mime-info less" \
    DEV_PACKAGES="build-base curl-dev" \
    HOME="/app" \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo

WORKDIR ${HOME}

ADD Gemfile ${HOME}/Gemfile
ADD Gemfile.lock ${HOME}/Gemfile.lock

RUN apk update && \
    apk upgrade && \
    apk add --update --no-cache ${RUNTIME_PACKAGES} && \
    apk add --update --virtual build-dependencies --no-cache ${DEV_PACKAGES} && \
    bundle install -j4 && \
    apk del build-dependencies

ADD . ${HOME}

RUN bundle install
