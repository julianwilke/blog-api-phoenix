# Extend from the official Elixir image
FROM elixir:1.6

RUN apt-get update && \
  apt-get install -y postgresql-client && \
  apt-get install -y inotify-tools && \
  apt-get install -y manpages

ENV REBAR3_VERSION="3.6.1"

RUN set -xe \
	&& REBAR3_DOWNLOAD_URL="https://github.com/erlang/rebar3/archive/${REBAR3_VERSION}.tar.gz" \
	&& REBAR3_DOWNLOAD_SHA256="40b3c85440f3235c7b149578d0211bdf57d1c66390f888bb771704f8abc71033" \
	&& mkdir -p /usr/src/rebar3-src \
	&& curl -fSL -o rebar3-src.tar.gz "$REBAR3_DOWNLOAD_URL" \
	&& echo "$REBAR3_DOWNLOAD_SHA256 rebar3-src.tar.gz" | sha256sum -c - \
	&& tar -xzf rebar3-src.tar.gz -C /usr/src/rebar3-src --strip-components=1 \
	&& rm rebar3-src.tar.gz \
	&& cd /usr/src/rebar3-src \
	&& HOME=$PWD ./bootstrap \
	&& install -v ./rebar3 /usr/local/bin/ \
	&& rm -rf /usr/src/rebar3-src

# Create app directory and copy the Elixir projects into it
WORKDIR /src/blog

RUN addgroup blog && \
    useradd --create-home -u 1001 -g blog blog

COPY --chown=blog:blog . /src/blog

RUN chmod +x /src/blog/scripts/entrypoint.sh

USER blog

# Install hex package manager
# By using --force, we don’t need to type “Y” to confirm the installation
RUN mix local.hex --force && \
    mix local.rebar --force

# install phoenix
RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phx_new-1.3.4.ez

# RUN mix deps.get

# Compile the project
# RUN mix do compile

CMD ["/src/blog/scripts/entrypoint.sh"]