#!/bin/sh
# Upload the hosted pages and their assets. Docs, cms_stubs.html and this script stay local.
set -e
cd "$(dirname "$0")"
scp -r $(ls *.html | grep -v '^cms_stubs\.html$') css images pdf root@172.16.11.32:/var/www/html/website
