#!/bin/sh
set -e

rm -Rf tmp/
composer create-project "symfony/skeleton" tmp --prefer-dist --no-progress --no-interaction --no-install

cd tmp
cp -Rp . ..
cd -
rm -Rf tmp/

composer install --prefer-dist --no-progress --no-interaction