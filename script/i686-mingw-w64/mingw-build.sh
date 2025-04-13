#!/usr/bin/env bash

set -x
set -euo pipefail

# shellcheck disable=SC1091
. lib.sh

main() {
    # Need symlinks for specific autoconf versions, since it
    # attempts to use autoconf2.69 and autom4te2.69.
    ln -s /usr/bin/autoconf /usr/bin/autoconf2.69
    ln -s /usr/bin/autom4te /usr/bin/autom4te2.69
    # Replace installed mingw packages with the new ones
    dpkg -i /g*-mingw-w64-i686*.deb /gcc-mingw-w64-base*.deb
    rm -rf /g*-mingw-w64-i686*.deb /gcc-mingw-w64-base*.deb
    # Unlink our temporary aliases
    unlink /usr/bin/autoconf2.69
    unlink /usr/bin/autom4te2.69
}

main "${@}"