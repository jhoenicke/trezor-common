#!/bin/sh

set -e

cd $(dirname $0)

VERSION="1"

install -D -m 0644 ./trezor.rules    ./lib/udev/rules.d/52-trezor-extension.rules

NAME=trezor-udev

tar cfj $NAME-$VERSION.tar.bz2 ./lib

for TYPE in "deb" "rpm"; do
	fpm \
		-s tar \
		-t $TYPE \
		-a all \
		-n $NAME \
		-v $VERSION \
		--license "LGPL-3.0" \
		--vendor "SatoshiLabs" \
		--description "Udev rules for TREZOR" \
		--maintainer "SatoshiLabs <stick@satoshilabs.com>" \
		--url "http://bitcointrezor.com/" \
		--category "Productivity/Security" \
		$NAME-$VERSION.tar.bz2
done

rm $NAME-$VERSION.tar.bz2
rm -rf  ./lib
