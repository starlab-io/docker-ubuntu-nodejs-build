FROM starlabio/ubuntu-base:1.3
MAINTAINER Doug Goldstein <doug@starlab.io>

# add Node repo
ADD nodesource.list /etc/apt/sources.list.d/
RUN curl -sSf https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -

# add Yarn repo
RUN curl -sSf https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
ADD yarnpkg.list /etc/apt/sources.list.d/

ENV APT_GET_UPDATE 2017-08-17

RUN apt-get -y update && \
    apt-get --quiet --yes install \
        xvfb libgtk2.0-0 libxtst6 libxss1 libgconf-2-4 libasound2 \
        ruby ruby-dev nodejs yarn \
        icnsutils graphicsmagick xz-utils rpm bsdtar && \
        apt-get autoremove -y && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists* /tmp/* /var/tmp/*

RUN gem install fpm

ADD npmrc /etc/npmrc

ENV NODE_TLS_REJECT_UNAUTHORIZED=0

ENV SCREEN_WIDTH 1360
ENV SCREEN_HEIGHT 1020
ENV SCREEN_DEPTH 24
ENV DISPLAY :99.0

VOLUME ["/source"]
WORKDIR /source
CMD ["/bin/bash"]
