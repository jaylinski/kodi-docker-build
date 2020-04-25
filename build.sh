#!/usr/bin/env sh

set -e

cmake ./../source \
      -DCMAKE_INSTALL_PREFIX=/usr/local \
      -DENABLE_INTERNAL_DAV1D=ON \
      -DX11_RENDER_SYSTEM=gl

cmake --build . -- VERBOSE=1 -j2