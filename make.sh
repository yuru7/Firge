#!/bin/bash

BASE_DIR=$(cd $(dirname $0); pwd)
PREFIX="$1"

"${BASE_DIR}/firge_generator.sh" "$PREFIX" && "${BASE_DIR}/os2_patch.sh" "$PREFIX"
