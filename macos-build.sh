# https://github.com/rbenv/ruby-build/discussions/2129
brew install autoconf libyaml gmp readline bison openssl@1.1
git clone https://github.com/ruby/ruby --depth 1 --branch ruby_3_2
cd ruby
./autogen.sh
mkdir build && cd build
../configure --prefix="${HOME}/.rubies/ruby-3.2" --config-cache --disable-install-doc
PATH="$(brew --prefix bison)/bin:$PATH" \
  RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1) --disable-install-doc" make install

echo "Ruby has been installed in ~/.rubies/ruby-3.2"
echo "Use this command to run ruby:"
echo "RUBYLIB=./lib/ruby/3.2.0/arm64-darwin23:./lib/ruby/3.2.0 ./bin/ruby ./bin/irb"
