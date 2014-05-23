#!/bin/bash -eu

# Runs on the remote machine

# This runs as root on the server
[ $UID -eq 0 ]

json="$1"

cd $HOME/chef
chef-solo --config solo.rb --json-attributes "$json"

