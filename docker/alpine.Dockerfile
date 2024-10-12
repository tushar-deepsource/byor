FROM alpine:3.18 as build

RUN apk add \
		git curl make autoconf openssl-dev  \
		ruby bison zlib libtool yaml-dev g++

RUN mkdir /toolbox \
	&& git clone https://github.com/ruby/ruby --branch ruby_3_2 --depth 1 /toolbox/ruby

WORKDIR /toolbox/ruby

RUN ./autogen.sh \
	&& mkdir build \
	&& cd build \
	&& ../configure --prefix="${HOME}/.rubies/ruby-3.2" \
	&& make install

FROM alpine:3.18

COPY --from=build /root/.rubies /root/.rubies
