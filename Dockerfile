FROM starlabio/centos-base:1.0
MAINTAINER Doug Goldstein <doug@starlab.io>

# setup linkers for Cargo
RUN mkdir -p /root/.cargo/

ENV PATH "/root/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# install rustup
RUN curl https://sh.rustup.rs -sSf > rustup-install.sh && sh ./rustup-install.sh  -y && rm rustup-install.sh

# Install x86_64 Rust
RUN /root/.cargo/bin/rustup default 1.10.0-x86_64-unknown-linux-gnu

# Install rustfmt / cargo fmt for testing
RUN cargo install --root /usr/local rustfmt --vers 0.5.0
