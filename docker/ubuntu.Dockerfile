FROM ubuntu:18.04 as build

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update \
	&& apt-get -y upgrade \
	&& apt-get install -y --no-install-recommends \
		git curl make build-essential autoconf software-properties-common libssl-dev \
		ruby bison zlib1g-dev libtool libyaml-dev \
	&& apt-get purge -y --auto-remove software-properties-common \
	&& rm -rf /var/lib/apt/lists/*



RUN mkdir /toolbox \
	&& git clone https://github.com/ruby/ruby --branch ruby_3_2 --depth 1 /toolbox/ruby

WORKDIR /toolbox/ruby

RUN ./autogen.sh \
	&& mkdir build \
	&& cd build \
	&& ../configure --prefix="/root/.rubies/ruby-3.2" \
	&& make install

FROM ubuntu:23.04

COPY --from=build /root/.rubies /root/.rubies

CMD /root/.rubies/ruby-3.2/bin/irb
