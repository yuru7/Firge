#!/bin/bash

BASE_DIR="$(cd $(dirname $0); pwd)"

PREFIX="$1"

FONT_PATTERN=${PREFIX}'Firge*.ttf'

COPYRIGHT='[Fira]
Copyright (c) 2012-2015, The Mozilla Foundation and Telefonica S.A.

[Gen Shin Gothic / Gen Jyuu Gothic]
Copyright (c) 2015 JIKASEI FONT KOUBOU

[Nerd Fonts]
Copyright (c) 2014, Ryan L McIntyre (https://ryanlmcintyre.com).

[Firge]
Copyright (c) 2019, Yuko OTAWARA'

for P in ${BASE_DIR}/${FONT_PATTERN}
do
  ttx -t name "$P"
  mv "${P%%.ttf}.ttx" ${BASE_DIR}/tmp.ttx
  cat ${BASE_DIR}/tmp.ttx | perl -pe "s?###COPYRIGHT###?$COPYRIGHT?" > "${P%%.ttf}.ttx"

  mv "$P" "${P}_orig"
  ttx -m "${P}_orig" "${P%%.ttf}.ttx"
done

rm -f "${BASE_DIR}/"*.ttx "${BASE_DIR}/"*_orig
