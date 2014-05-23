#!/bin/bash -eu

# Runs on the remote machine

RUBY="2.1.2"
MD5="a5b5c83565f8bd954ee522bd287d2ca1"

# This runs as root on the server
[ $UID -eq 0 ]

set +u
[ -z "$TMUX" ] && {
  echo "You might want to \`apt-get install tmux' and run $0 from there. Press CTRL-C to cancel and do this."
  read
}
set -u

# Install Ruby and Chef if we are on a vanilla system
command -v ruby >/dev/null || {
  apt-get update

  # wget: to fetch Ruby and pretty useful anyway
  # gcc make: to compile Ruby
  # zlib1g-dev libssl-dev libreadline-dev: libraries for Ruby
  # git-core: useful!

  apt-get install wget gcc make zlib1g-dev libssl-dev libreadline-dev git-core

  cd /tmp
  wget http://cache.ruby-lang.org/pub/ruby/stable/ruby-${RUBY}.tar.gz
  echo "${MD5}  ruby-${RUBY}.tar.gz" | md5sum -c -
  tar xf ruby-${RUBY}.tar.gz

  cd ruby-${RUBY}/
  ./configure --disable-install-doc
  make
  make install

  rm -rf /tmp/ruby-${RUBY}
  cd

  ruby -v
}

command -v chef-solo >/dev/null || {
  gem install chef --no-rdoc --no-ri

  chef-solo -v
}

echo "All good to go!"

