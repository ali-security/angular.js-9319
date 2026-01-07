#!/bin/bash
set -e

# Install phase
echo '>>> Install Phase'
echo \"legacy-peer-deps=true\nregistry=https://time-machines-npm.sealsecurity.io/\n//time-machines-npm.sealsecurity.io/:_authToken=2020-06-04T16:24:38.629Z\" > .npmrc
du -sh ./node_modules ./bower_components/ ./docs/bower_components/ || true
npm --version
npm install -g npm@2.5.1
node --version

npm config set spin false
npm config set loglevel http

# Create directory for local repos
mkdir -p /tmp/local-repos

# Clone grunt-jasmine-node
cd /tmp/local-repos
git clone https://github.com/vojtajina/grunt-jasmine-node.git
cd /tmp/local-repos/grunt-jasmine-node
git checkout ced17cbe52c1412b2ada53160432a5b681f37cd7

# Clone traceur-compiler  
cd /tmp/local-repos
git clone https://github.com/vojtajina/traceur-compiler.git
cd /tmp/local-repos/traceur-compiler
git checkout d90b1e34c799bf61cd1aafdc33db0a554fa9e617

# Download component/global tar.gz
cd /tmp/local-repos
wget -O component-global-v2.0.1.tar.gz https://github.com/component/global/archive/v2.0.1.tar.gz

# Download node-XMLHttpRequest tar.gz
cd /tmp/local-repos
wget -O node-XMLHttpRequest-a6b6f2.tar.gz https://github.com/rase-/node-XMLHttpRequest/archive/a6b6f2.tar.gz


cp -r /app/Git/angular.js /tmp/

cd /tmp/angular.js
npm install -g bower@1.3.9
npm install -g grunt-cli@0.1.13

npm install
bower install


# Before script phase
echo '>>> Before Script Phase'
mkdir -p $LOGS_DIR
./scripts/travis/start_browser_provider.sh
grunt package
./scripts/travis/wait_for_browser_provider.sh

# Custom script (if it exists)
if [ -f custom_script.sh ]; then
  echo '>>> Running Custom Script'
  bash custom_script.sh || true
fi

# Script phase (run tests)
echo '>>> Script Phase (Running Tests)'
./scripts/travis/build.sh

# After script phase
echo '>>> After Script Phase'
./scripts/travis/tear_down_browser_provider.sh || true
./scripts/travis/print_logs.sh || true