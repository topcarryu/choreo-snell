#!/usr/bin/env bash

set -e
exec 2>&1

PASSWD=${PASSWD:-'abcdefg'}
WSPATH=${WSPATH:-'user'}

generate_config() {
  cat > /tmp/config.json << EOF
[snell-server]
listen = 0.0.0.0:55678
psk = abcde
obfs = tls
obfs-host = www.bing.com
EOF
}

generate_pm2_file() {
  cat > /tmp/ecosystem.config.js << EOF
module.exports = {
  apps: [
    {
      name: "web",
      script: "/usr/src/app/snell* -c /tmp/config.json"
    }
  ]
}
EOF
}


generate_config
generate_pm2_file

[ -e /tmp/ecosystem.config.js ] && pm2 start /tmp/ecosystem.config.js
