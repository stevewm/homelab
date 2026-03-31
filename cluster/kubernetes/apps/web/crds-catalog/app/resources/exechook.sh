#!/bin/sh

git -C /var/www/crds ls-files '*.json' | sed 's|^|crds/|' | sort | sed 's/.*$/\"&\"/' | paste -sd, | sed 's/.*/[&]/' >/var/www/search-index.json
