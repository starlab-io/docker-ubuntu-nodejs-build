FROM starlabio/ubuntu-base:1.0
MAINTAINER Doug Goldstein <doug@starlab.io>

ENV NODE_VERSION 6.1.0

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" && \
        tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 && \
        rm "node-v$NODE_VERSION-linux-x64.tar.xz" && \
        npm install -g npm && \
        printf '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bashrc

RUN apt-get update && \
    apt-get --quiet --yes install \
        xvfb libgtk2.0-0 libxtst6 libxss1 libgconf-2-4 libasound2 \
        icnsutils graphicsmagick xz-utils rpm bsdtar && \
        apt-get autoremove -y && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists* /tmp/* /var/tmp/*

ADD npmrc /etc/npmrc

ENV NODE_TLS_REJECT_UNAUTHORIZED=0

ENV SCREEN_WIDTH 1360
ENV SCREEN_HEIGHT 1020
ENV SCREEN_DEPTH 24
ENV DISPLAY :99.0

VOLUME ["/source"]
WORKDIR /source
CMD ["/bin/bash"]
