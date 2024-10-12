set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

apt update \
	&& apt-get -y upgrade \
	&& apt-get install -y --no-install-recommends \
		git curl make build-essential autoconf software-properties-common libssl-dev \
		ruby bison zlib1g-dev libtool libyaml-dev

mkdir ./toolbox && git clone https://github.com/ruby/ruby --branch ruby_3_2 --depth 1 ./toolbox/ruby

cd ./toolbox/ruby

./autogen.sh \
	&& mkdir build \
	&& cd build \
	&& ../configure --prefix="$HOME/rubies/ruby-3.2" \
	&& make install

