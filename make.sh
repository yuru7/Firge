#!/bin/bash

FIRGE_VERSION="0.3.0"

BASE_DIR=$(cd $(dirname $0); pwd)
PREFIX="$1"

"${BASE_DIR}/firge_generator.sh" "$FIRGE_VERSION" "$PREFIX" \
&& "${BASE_DIR}/copyright.sh" "$PREFIX" \
&& "${BASE_DIR}/os2_patch.sh" "$PREFIX"
