#!/bin/sh
set -e # When this option is on returns an exit status value >0

rm -Rf tmp/
composer create-project "symfony/skeleton $1" tmp --prefer-dist --no-progress --no-interaction --no-install

cd tmp
cp -Rp . ..
cd -
rm -Rf tmp/

composer install --prefer-dist --no-progress --no-interaction