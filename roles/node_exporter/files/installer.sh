#!/bin/bash

set -e

url=$(curl -s https://api.github.com/repos/prometheus/node_exporter/releases/latest | jq -r '.assets[].browser_download_url | select(. | contains("linux-amd64"))')
mkdir -p /var/cache/node_exporter
if [ -f /var/cache/node_exporter/installed_url ] && [ "$(cat /var/cache/node_exporter/installed_url)" = "$url" ]; then
  echo "Latest version already installed"
  exit
fi

echo "Downloading from $url ..."
rm -rf /tmp/node_exporter
mkdir /tmp/node_exporter
curl -sL "$url" > /tmp/node_exporter.tar.gz

echo "Installing binaries to /usr/local/bin ..."
tar -C /tmp/node_exporter -zxf /tmp/node_exporter.tar.gz

was_active=0
if systemctl is-active -q node-exporter; then
  was_active=1
  systemctl stop node-exporter
fi
cp -a /tmp/node_exporter/node_exporter-*/node_exporter /usr/local/bin
if [ "$was_active" = "1" ]; then
  echo "Restarting node-exporter.service ..."
  systemctl start node-exporter
fi

rm -rf /tmp/node_exporter
echo "$url" > /var/cache/node_exporter/installed_url
