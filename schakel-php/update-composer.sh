#!/usr/bin/env bash

set -xe

wget -O /tmp/composer-setup.php https://getcomposer.org/installer

EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig)
ACTUAL_SIGNATURE=$(openssl sha384 -r /tmp/composer-setup.php | awk \{print\ \$1\})

if [ "$EXPECTED_SIGNATURE" = "$ACTUAL_SIGNATURE" ];
then
    cp /tmp/composer-setup.php composer-setup.php
    rm /tmp/composer-setup.php
else
    echo "ERROR: Invalid Composer signature"
    rm /tmp/composer-setup.php
    exit 1
fi
