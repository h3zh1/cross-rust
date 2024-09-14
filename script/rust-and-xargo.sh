#!/usr/bin/env bash

set -x
set -euo pipefail

# shellcheck disable=SC1091
. lib.sh

main() {
    install_packages ca-certificates curl

    TOOLCHAIN_VERSION=${1:-stable}

    curl --retry 3 -sSfL https://sh.rustup.rs -o rustup-init.sh
    sh rustup-init.sh -y --no-modify-path --profile minimal --default-toolchain "${TOOLCHAIN_VERSION}"
    rm rustup-init.sh

    cargo install xargo --root /usr/local

    purge_packages

    rm "${0}"
}

main "${@}"
