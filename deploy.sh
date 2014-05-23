#!/bin/bash -eu

# Runs on the local machine
# Copies files to the server and runs chef-solo

if [ $# -ne 2 ]; then
  echo "Usage: ./deploy.sh [host] [json]" >&2
  echo "e.g. ./deploy.sh server_name nodes/server_name.json" >&2
  exit 1
fi

host="${1}"
json="${2}"

tar cj . | \ssh "$host" "
sudo rm -rf ~/chef &&
mkdir ~/chef &&
cd ~/chef &&
tar xj &&
chown -R 0.0 ~/chef &&
sudo bash converge.sh $json"

