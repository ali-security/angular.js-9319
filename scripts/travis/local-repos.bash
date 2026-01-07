#!/bin/bash
set -e

# Create directory for local repos
mkdir -p /tmp/local-repos

# Clone grunt-jasmine-node
(
    cd /tmp/local-repos
    git clone https://github.com/vojtajina/grunt-jasmine-node.git
    cd /tmp/local-repos/grunt-jasmine-node
    git checkout ced17cbe52c1412b2ada53160432a5b681f37cd7
)

# Clone traceur-compiler  
(
    cd /tmp/local-repos
    git clone https://github.com/vojtajina/traceur-compiler.git
    cd /tmp/local-repos/traceur-compiler
    git checkout d90b1e34c799bf61cd1aafdc33db0a554fa9e617
)

# Download component/global tar.gz
(
    cd /tmp/local-repos
    wget -O component-global-v2.0.1.tar.gz https://github.com/component/global/archive/v2.0.1.tar.gz
)

# Download node-XMLHttpRequest tar.gz
(
    cd /tmp/local-repos
    wget -O node-XMLHttpRequest-a6b6f2.tar.gz https://github.com/rase-/node-XMLHttpRequest/archive/a6b6f2.tar.gz
)