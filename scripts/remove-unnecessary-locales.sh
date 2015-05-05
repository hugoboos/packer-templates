#!/bin/bash

LOCALE_TO_KEEP="en_US"

# Remove unnecessary locales
find /usr/share/locale -mindepth 1 -maxdepth 1 -type d | grep -v -e "${LOCALE_TO_KEEP}" | xargs rm -rf

# Removed locales from locale-archive
localedef --list-archive | grep -v -e "${LOCALE_TO_KEEP}" | xargs localedef --delete-from-archive
mv -f /usr/lib/locale/locale-archive /usr/lib/locale/locale-archive.tmpl
build-locale-archive
