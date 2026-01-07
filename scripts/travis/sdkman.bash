set -e

sudo apt-get update -qq
sudo apt-get install -y curl zip unzip
curl -s "https://get.sdkman.io" | bash
# You'll be prompted to follow on-screen instructions.
# After installation, you need to source the init script to make 'sdk' command available in current shell:
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 7.0.352-zulu
sdk use java 7.0.352-zulu

# used to discover home
export JAVA_HOME="$HOME/.sdkman/candidates/java/current"
echo "$JAVA_HOME"
