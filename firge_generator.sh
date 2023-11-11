#!/bin/sh

base_dir=$(cd $(dirname $0); pwd)
# Firge Generator
firge_version="$1"

# Set familyname
familyname_preffix="$2"
firge_familyname=${familyname_preffix}"Firge"
firge_familyname_suffix=""
firge35_familyname=${firge_familyname}"35"
firge35_familyname_suffix=""
firge_console_suffix="Console"
firge_evacuation_nerd_familyname="Evacuation${firge_familyname}Nerd"
firge35_evacuation_nerd_familyname="Evacuation${firge35_familyname}Nerd"
firge_nerd_familyname=${firge_familyname}"Nerd"
firge35_nerd_familyname=${firge35_familyname}"Nerd"
firge_evacuation_symbol_familyname=${firge_familyname}"EvacuationSymbol"
firge35_evacuation_symbol_familyname=${firge35_familyname}"EvacuationSymbol"
firge_box_drawing_light_familyname=${firge_familyname}"BoxDrawingLight"
firge35_box_drawing_light_familyname=${firge35_familyname}"BoxDrawingLight"

copyright='###COPYRIGHT###'

# Set ascent and descent (line width parameters)
firge_ascent=938
firge_descent=210
firge35_ascent=951
firge35_descent=243

em_ascent=881
em_descent=143
em=$(($em_ascent + $em_descent))

typo_line_gap=80

hack_width=616
genjyuu_width=1024

firge_half_width=540
firge_full_width=$((${firge_half_width} * 2))
hack_shrink_x=88
hack_shrink_y=93

firge35_half_width=618
firge35_full_width=$((${firge35_half_width} * 5 / 3))

# Set path to fontforge command
fontforge_command="fontforge"
ttfautohint_command="ttfautohint"

# Set redirection of stderr
redirection_stderr="/dev/null"

# Set fonts directories used in auto flag
fonts_directories="${base_dir}/source/"

# Set zenkaku space glyph
zenkaku_space_glyph=""

# Set flags
leaving_tmp_flag="false"
fullwidth_ambiguous_flag="true"
scaling_down_flag="true"

# Set non-Discorded characters
non_discorded_characters=""

# Set filenames
hack_regular_src="FiraMono-Regular.ttf"
hack_bold_src="FiraMono-Bold.ttf"
mod_fira_regular_src="modify_FiraMono-Regular.sfd"
mod_fira_bold_src="modify_FiraMono-Bold.sfd"

mod_arrow_regular_src="modify_arrow_Hack-Regular.sfd"
mod_arrow_bold_src="modify_arrow_Hack-Bold.sfd"
nerd_patched_hack_regular_src="FiraMonoNerdFont-Regular.otf"
nerd_patched_hack_bold_src="FiraMonoNerdFont-Bold.otf"
genjyuu_regular_src="GenShinGothic-Monospace-Normal.ttf"
genjyuu_bold_src="GenShinGothic-Monospace-Bold.ttf"

modified_hack_material_generator="modified_hack_material_generator.pe"
modified_hack_material_regular="Modified-Hack-Material-Regular.sfd"
modified_hack_material_bold="Modified-Hack-Material-Bold.sfd"

modified_hack_powerline_generator="modified_hack_powerline_generator.pe"
modified_hack_powerline_regular="Modified-Hack-Powerline-Regular.sfd"
modified_hack_powerline_bold="Modified-Hack-Powerline-Bold.sfd"

modified_hack35_powerline_generator="modified_hack35_powerline_generator.pe"
modified_hack35_powerline_regular="Modified-Hack35-Powerline-Regular.sfd"
modified_hack35_powerline_bold="Modified-Hack35-Powerline-Bold.sfd"

modified_hack_box_drawing_light_generator="modified_hack_box_drawing_light_generator.pe"
modified_hack_box_drawing_light_regular="Modified-Hack-box_drawing_light-Regular.sfd"
modified_hack_box_drawing_light_bold="Modified-Hack-box_drawing_light-Bold.sfd"

modified_hack35_box_drawing_light_generator="modified_hack35_box_drawing_light_generator.pe"
modified_hack35_box_drawing_light_regular="Modified-Hack35-box_drawing_light-Regular.sfd"
modified_hack35_box_drawing_light_bold="Modified-Hack35-box_drawing_light-Bold.sfd"

modified_hack_evacuate_from_hinting_generator="modified_hack_evacuate_from_hinting_generator.pe"
modified_hack_evacuate_from_hinting_regular="Modified-Hack-Evacuate_From_Hinting-Regular.sfd"
modified_hack_evacuate_from_hinting_bold="Modified-Hack-Evacuate_From_Hinting-Bold.sfd"

modified_hack35_evacuate_from_hinting_generator="modified_hack35_evacuate_from_hinting_generator.pe"
modified_hack35_evacuate_from_hinting_regular="Modified-Hack35-Evacuate_From_Hinting-Regular.sfd"
modified_hack35_evacuate_from_hinting_bold="Modified-Hack35-Evacuate_From_Hinting-Bold.sfd"

modified_hack_console_generator="modified_hack_console_generator.pe"
modified_hack_console_regular="Modified-Hack-Console-Regular.sfd"
modified_hack_console_bold="Modified-Hack-Console-Bold.sfd"

modified_hack35_console_generator="modified_hack35_console_generator.pe"
modified_hack35_console_regular="Modified-Hack35-Console-Regular.sfd"
modified_hack35_console_bold="Modified-Hack35-Console-Bold.sfd"

modified_hack_generator="modified_hack_generator.pe"
modified_hack_regular="Modified-Hack-Regular.sfd"
modified_hack_bold="Modified-Hack-Bold.sfd"

modified_hack35_generator="modified_hack35_generator.pe"
modified_hack35_regular="Modified-Hack35-Regular.sfd"
modified_hack35_bold="Modified-Hack35-Bold.sfd"

modified_genjyuu_generator="modified_genjyuu_generator.pe"
modified_genjyuu_regular="Modified-GenJyuuGothicL-Monospace-regular.sfd"
modified_genjyuu_bold="Modified-GenJyuuGothicL-Monospace-bold.sfd"

modified_genjyuu35_generator="modified_genjyuu35_generator.pe"
modified_genjyuu35_regular="Modified-GenJyuuGothicL35-Monospace-regular.sfd"
modified_genjyuu35_bold="Modified-GenJyuuGothicL35-Monospace-bold.sfd"

modified_genjyuu_console_generator="modified_genjyuu_console_generator.pe"
modified_genjyuu_console_regular="Modified-GenJyuuGothicL-Monospace-regular_console.sfd"
modified_genjyuu_console_bold="Modified-GenJyuuGothicL-Monospace-bold_console.sfd"

modified_genjyuu35_console_generator="modified_genjyuu35_console_generator.pe"
modified_genjyuu35_console_regular="Modified-GenJyuuGothicL35-Monospace-regular_console.sfd"
modified_genjyuu35_console_bold="Modified-GenJyuuGothicL35-Monospace-bold_console.sfd"

modified_firge_nerd_symbol_generator="modified_firge_nerd_symbol_generator.pe"
modified_firge_nerd_symbol_regular="Modified-Firge-Nerd-Symbol-Regular.sfd"
modified_firge_nerd_symbol_bold="Modified-Firge-Nerd-Symbol-Bold.sfd"

modified_firge35_nerd_symbol_generator="modified_firge35_nerd_symbol_generator.pe"
modified_firge35_nerd_symbol_regular="Modified-Firge35-Nerd-Symbol-Regular.sfd"
modified_firge35_nerd_symbol_bold="Modified-Firge35-Nerd-Symbol-Bold.sfd"

modified_firge_nerd_console_symbol_generator="modified_firge_nerd_console_symbol_generator.pe"
modified_firge_nerd_console_symbol_regular="Modified-Firge-Nerd-Console-Symbol-Regular.sfd"
modified_firge_nerd_console_symbol_bold="Modified-Firge-Nerd-Console-Symbol-Bold.sfd"

modified_firge35_nerd_console_symbol_generator="modified_firge35_nerd_console_symbol_generator.pe"
modified_firge35_nerd_console_symbol_regular="Modified-Firge35-Nerd-Console-Symbol-Regular.sfd"
modified_firge35_nerd_console_symbol_bold="Modified-Firge35-Nerd-Console-Symbol-Bold.sfd"

firge_generator="firge_generator.pe"
firge_console_generator="firge_console_generator.pe"
firge_evacuate_from_hinting_generator="firge_evacuate_from_hinting_generator.pe"
firge_box_drawing_light_generator="firge_box_drawing_light_generator.pe"
firge_nerd_symbol_generator="firge_nerd_symbol_generator.pe"
firge_nerd_console_symbol_generator="firge_nerd_console_symbol_generator.pe"

firge35_generator="firge35_generator.pe"
firge35_console_generator="firge35_console_generator.pe"
firge35_evacuate_from_hinting_generator="firge35_evacuate_from_hinting_generator.pe"
firge35_box_drawing_light_generator="firge35_box_drawing_light_generator.pe"
firge35_nerd_symbol_generator="firge35_nerd_symbol_generator.pe"
firge35_nerd_console_symbol_generator="firge35_nerd_console_symbol_generator.pe"

# Get input fonts
tmp=""
for i in $fonts_directories
do
    [ -d "${i}" ] && tmp="${tmp} ${i}"
done
fonts_directories="${tmp}"
# Search Hack
input_hack_regular=`find $fonts_directories -follow -name "$hack_regular_src" | head -n 1`
input_hack_bold=`find $fonts_directories -follow -name "$hack_bold_src" | head -n 1`
input_mod_fira_regular=`find $fonts_directories -follow -name "$mod_fira_regular_src" | head -n 1`
input_mod_fira_bold=`find $fonts_directories -follow -name "$mod_fira_bold_src" | head -n 1`
input_mod_arrow_regular=`find $fonts_directories -follow -name "$mod_arrow_regular_src" | head -n 1`
input_mod_arrow_bold=`find $fonts_directories -follow -name "$mod_arrow_bold_src" | head -n 1`

if [ -z "${input_hack_regular}" -o -z "${input_hack_bold}" ]
then
  echo "Error: $hack_regular_src and/or $hack_bold_src not found" >&2
  exit 1
fi
if [ -z "${input_mod_fira_regular}" -o -z "${input_mod_fira_bold}" ]
then
  echo "Error: $input_mod_fira_regular and/or $input_mod_fira_bold not found" >&2
  exit 1
fi
if [ -z "${input_mod_arrow_regular}" -o -z "${input_mod_arrow_bold}" ]
then
  echo "Error: $input_mod_arrow_regular and/or $input_mod_arrow_bold not found" >&2
  exit 1
fi

# Search GenJyuuGothicL
input_genjyuu_regular=`find $fonts_directories -follow -iname "$genjyuu_regular_src" | head -n 1`
input_genjyuu_bold=`find $fonts_directories -follow -iname "$genjyuu_bold_src"    | head -n 1`
if [ -z "${input_genjyuu_regular}" -o -z "${input_genjyuu_bold}" ]
then
  echo "Error: $genjyuu_regular_src and/or $genjyuu_bold_src not found" >&2
  exit 1
fi

# Search improved legibility file
input_improved_legibility_regular=`find $fonts_directories -follow -iname improved_legibility-Regular.sfd | head -n 1`
input_improved_legibility_bold=`find $fonts_directories -follow -iname improved_legibility-Bold.sfd    | head -n 1`

# Search REIWA
input_reiwa_regular=`find $fonts_directories -follow -iname reiwa-Regular.sfd | head -n 1`
input_reiwa_bold=`find $fonts_directories -follow -iname reiwa-Bold.sfd    | head -n 1`

# Search Ideographic Space
input_ideographic_space=`find $fonts_directories -follow -iname Ideographic_Space.sfd | head -n 1`

# Search nerd patched hack
input_nerd_patched_hack_regular=`find $fonts_directories -follow -iname "$nerd_patched_hack_regular_src" | head -n 1`
input_nerd_patched_hack_bold=`find $fonts_directories -follow -iname "$nerd_patched_hack_bold_src"    | head -n 1`

# Check filename
[ "$(basename $input_hack_regular)" != "$hack_regular_src" ] &&
  echo "Warning: ${input_hack_regular} does not seem to be Hack Regular" >&2
[ "$(basename $input_hack_bold)" != "$hack_bold_src" ] &&
  echo "Warning: ${input_hack_regular} does not seem to be Hack Bold" >&2
[ "$(basename $input_genjyuu_regular)" != "$genjyuu_regular_src" ] &&
  echo "Warning: ${input_genjyuu_regular} does not seem to be GenJyuuGothicL Regular" >&2
[ "$(basename $input_genjyuu_bold)" != "$genjyuu_bold_src" ] &&
  echo "Warning: ${input_genjyuu_bold} does not seem to be GenJyuuGothicL Bold" >&2

# Check fontforge existance
if ! which $fontforge_command > /dev/null 2>&1
then
  echo "Error: ${fontforge_command} command not found" >&2
  exit 1
fi

# Make temporary directory
if [ -w "/tmp" -a "${leaving_tmp_flag}" = "false" ]
then
  tmpdir=`mktemp -d /tmp/firge_generator_tmpdir.XXXXXX` || exit 2
else
  tmpdir=`mktemp -d ./firge_generator_tmpdir.XXXXXX`    || exit 2
fi

# Remove temporary directory by trapping
if [ "${leaving_tmp_flag}" = "false" ]
then
  trap "if [ -d \"$tmpdir\" ]; then echo 'Remove temporary files'; rm -rf $tmpdir; echo 'Abnormally terminated'; fi; exit 3" HUP INT QUIT
  trap "if [ -d \"$tmpdir\" ]; then echo 'Remove temporary files'; rm -rf $tmpdir; echo 'Abnormally terminated'; fi" EXIT
else
  trap "echo 'Abnormally terminated'; exit 3" HUP INT QUIT
fi

# Powerline フォント (Hack に標準で含まれている)
powerline_symbols='
  SelectMore(0ue0a0, 0ue0a2)
  SelectMore(0ue0b0, 0ue0b3)
'

# 拡張版 Powerline フォント
powerline_extra_symbols='
  SelectMore(0ue0a3)
  SelectMore(0ue0b4, 0ue0c8)
  SelectMore(0ue0ca)
  SelectMore(0ue0cc, 0ue0d2)
  SelectMore(0ue0d4)
'

# Nerd Fonts から適用するグリフ
select_nerd_symbols="
  # IEC Power Symbols
  SelectMore(0u23fb, 0u23fe)
  SelectMore(0u2b58)
  # Octicons
  SelectMore(0u2665)
  SelectMore(0u26a1)
  SelectMore(0uf400, 0uf532)
  # Pomicons
  SelectMore(0ue000, 0ue00a)
  # Font Awesome Extension
  SelectMore(0ue200, 0ue2a9)
  # Weather Icons
  SelectMore(0ue300, 0ue3e3)
  # Seti-UI + Custom
  SelectMore(0ue5fa, 0ue6ac)
  # Devicons
  SelectMore(0ue700, 0ue7c5)
  # Codicons
  SelectMore(0uea60, 0uebeb)
  # Font Awesome
  SelectMore(0uf000, 0uf2e0)
  # Font Logos
  SelectMore(0uf300, 0uf32f)
  # Material Design
  SelectMore(0uf0001, 0uf1af0)
  # Other
  SelectMore(0u2630)
"

# 罫線記号
box_drawing_light_symbols="
  SelectMore(0u2500, 0u259f)
"

# ヒンティング処理から除外するグリフ
select_evacuate_from_hinting="
  ${powerline_symbols}
"

# console 版と通常版の Hack から合成するグリフ差分
select_glyph_is_not_console="
  ${box_drawing_light_symbols}

  # 記号
  SelectMore(0u00a1, 0u00a5)
  SelectMore(0u00a7, 0u0522)
  SelectMore(0u0e3f)
  SelectMore(0u2010, 0u2021)
  SelectMore(0u2024, 0u2026)
  SelectMore(0u202f, 0u204b)
  SelectMore(0u2070, 0u208e)
  SelectMore(0u20a0, 0u20b9)
  SelectMore(0u2116, 0u215f)
  SelectMore(0u2200, 0u2215)
  SelectMore(0u221a, 0u222d)

  # 矢印
  SelectMore(0u2190, 0u2199)
  SelectMore(0u21a8)
  SelectMore(0u21b0, 0u21b5)
  SelectMore(0u21b8, 0u21b9)
  SelectMore(0u21c4, 0u21cc)
  SelectMore(0u21d0, 0u21d9)
  SelectMore(0u21e4, 0u21ed)
  SelectMore(0u21f5)
  SelectMore(0u27a1)
  SelectMore(0u2b05, 0u2b07)

  # 数学記号
  SelectMore(0u2234, 0u2237)
  SelectMore(0u223c, 0u223d)
  SelectMore(0u2242, 0u2243)
  SelectMore(0u2245)
  SelectMore(0u2248)
  SelectMore(0u224c)
  SelectMore(0u2250, 0u2253)
  SelectMore(0u2260)
  SelectMore(0u2260, 0u2262)
  SelectMore(0u2264, 0u2267)
  SelectMore(0u226a, 0u226b)
  SelectMore(0u226e, 0u226f)
  SelectMore(0u2272, 0u2273)
  SelectMore(0u2276, 0u2277)
  SelectMore(0u2282, 0u228b)
  SelectMore(0u2295, 0u2299)
  SelectMore(0u229d)
  SelectMore(0u22a0)
  SelectMore(0u22a2, 0u22a5)
  SelectMore(0u22bb, 0u22bd)
  SelectMore(0u22bf, 0u22c3)
  SelectMore(0u22c5)
  SelectMore(0u22da, 0u22db)
  SelectMore(0u22ee, 0u22ef)

  # 罫線、図形
  SelectMore(0u2500, 0u25af)
  SelectMore(0u25b1, 0u25b3)
  SelectMore(0u25b6, 0u25b7)
  SelectMore(0u25ba, 0u25bd)
  SelectMore(0u25c0, 0u25c1)
  SelectMore(0u25c4, 0u25cc)
  SelectMore(0u25ce, 0u25d3)
  SelectMore(0u25d8, 0u25d9)
  SelectMore(0u25e2, 0u25e5)
  SelectMore(0u25af)
  SelectMore(0u25e6)
  SelectMore(0u25ef)
  SelectMore(0u266a)
  SelectMore(0u2756)
  SelectMore(0u29fa, 0u29fb)
  SelectMore(0u2A2F)
  SelectMore(0u2b1a)

  # 一部 Hack ベースにする
  ## 各エディタの可視化文字対策
  SelectFewer(0u2022)
  SelectFewer(0u00b7)
  SelectFewer(0u2024)
  SelectFewer(0u2219)
  SelectFewer(0u25d8)
  SelectFewer(0u25e6)
  "

########################################
# Generate script for modified Hack Material
########################################

cat > ${tmpdir}/${modified_hack_material_generator} << _EOT_
#!$fontforge_command -script

Print("Generate modified Hack Material")

# Set parameters
input_list  = ["${input_hack_regular}",    "${input_hack_bold}"]
input_mod_list  = ["${input_mod_fira_regular}",    "${input_mod_fira_bold}"]
# input_mod_arrow_list  = ["${input_mod_arrow_regular}",    "${input_mod_arrow_bold}"]
output_list = ["${modified_hack_material_regular}", "${modified_hack_material_bold}"]

# Begin loop of regular and bold
i = 0
while (i < SizeOf(input_list))
  # Open Hack
  Print("Open " + input_list[i])
  Open(input_list[i])

  # 修正グリフの取り込み
  Select(0u0030)      # 0
  SelectMore(0u0026) # &
  SelectMore(0u002A, 0u002B) # * +
  SelectMore(0u007C) # |
  Clear()
  MergeFonts(input_mod_list[i])

  # 修正した矢印記号グリフの取り込み
#  Select(0u2190, 0u2199)
#  SelectMore(0u21E0, 0u21E3) # Dashed Arrow
#  SelectMore(0u21D0, 0u21D9) # Double Arrow
#  Clear()
#  MergeFonts(input_mod_arrow_list[i])

  SelectWorthOutputting()
  UnlinkReference()
  ScaleToEm(${em_ascent}, ${em_descent})

  # クォーテーションの拡大
  Select(0u0022)
  SelectMore(0u0027)
  SelectMore(0u0060)
  Scale(109, 106)

  # ; : , . の拡大
#  Select(0u003a)
#  SelectMore(0u003b)
#  SelectMore(0u002c)
#  SelectMore(0u002e)
#  Scale(108)
  ## 拡大後の位置合わせ
#  Select(0u003b); Move(0, 18) # ;
#  Select(0u002e); Move(0, 5)  # .
#  Select(0u002c); Move(0, -8) # ,

  # Eclipse Pleiades 半角スペース記号 (U+1d1c) 対策
  Select(0u054d); Copy()
  Select(0u1d1c); Paste()
  Scale(85, 60)

  # 結合分音記号は全て源柔ゴシックをベースにするため削除する
#  Select(0u0300, 0u036f); Clear()

  # パスの小数点以下を切り捨て
  SelectWorthOutputting()
  RoundToInt()

  # Save modified Hack
  Print("Save " + output_list[i])
  Save("${tmpdir}/" + output_list[i])

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate script for extracting evacuation symbol from hinting for Firge
########################################

cat > ${tmpdir}/${modified_hack_evacuate_from_hinting_generator} << _EOT_
#!$fontforge_command -script

Print("Generate evacuation symbol from hinting for Firge")

# Set parameters
input_list  = ["${tmpdir}/${modified_hack_material_regular}", "${tmpdir}/${modified_hack_material_bold}"]
output_list = ["${modified_hack_evacuate_from_hinting_regular}", "${modified_hack_evacuate_from_hinting_bold}"]

# Begin loop of regular and bold
i = 0
while (i < SizeOf(input_list))
  # Open Hack
  Print("Open " + input_list[i])
  Open(input_list[i])
  SelectWorthOutputting()
  UnlinkReference()

  Scale(${hack_shrink_x}, ${hack_shrink_y}, 0, 0)

  # 幅の変更 (Move で文字幅も変わることに注意)
  move_pt = $(((${firge_half_width} - ${hack_width} * ${hack_shrink_x} / 100) / 2)) # -8
  width_pt = ${firge_half_width}
  Move(move_pt, 0)
  SetWidth(width_pt, 0)

  # 特定の記号のみを残し、残りを削除
  SelectNone()
  ${select_evacuate_from_hinting}
  SelectInvert()
  Clear()

  # パスの小数点以下を切り捨て
  SelectWorthOutputting()
  RoundToInt()

  # Save modified Hack
  Print("Save " + output_list[i])
  Save("${tmpdir}/" + output_list[i])

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate script for extracting evacuation symbol from hinting for Firge35
########################################

cat > ${tmpdir}/${modified_hack35_evacuate_from_hinting_generator} << _EOT_
#!$fontforge_command -script

Print("Generate evacuation symbol from hinting for Firge")

# Set parameters
input_list  = ["${tmpdir}/${modified_hack_material_regular}", "${tmpdir}/${modified_hack_material_bold}"]
output_list = ["${modified_hack35_evacuate_from_hinting_regular}", "${modified_hack35_evacuate_from_hinting_bold}"]

# Begin loop of regular and bold
i = 0
while (i < SizeOf(input_list))
  # Open Hack
  Print("Open " + input_list[i])
  Open(input_list[i])
  SelectWorthOutputting()
  UnlinkReference()

  # 幅の変更 (Move で文字幅も変わることに注意)
  move_pt = $(((${firge35_half_width} - ${hack_width}) / 2)) # -8
  width_pt = ${firge35_half_width}
  Move(move_pt, 0)
  SetWidth(width_pt, 0)

  # 特定の記号のみを残し、残りを削除
  SelectNone()
  ${select_evacuate_from_hinting}
  SelectInvert()
  Clear()

  # パスの小数点以下を切り捨て
  SelectWorthOutputting()
  RoundToInt()

  # Save modified Hack
  Print("Save " + output_list[i])
  Save("${tmpdir}/" + output_list[i])

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate extraction powerline symbol script for Firge
########################################

cat > ${tmpdir}/${modified_hack_powerline_generator} << _EOT_
#!$fontforge_command -script

Print("Generate powerline symbol for Firge")

# Set parameters
input_list  = ["${input_nerd_patched_hack_regular}",    "${input_nerd_patched_hack_bold}"]
output_list = ["${modified_hack_powerline_regular}", "${modified_hack_powerline_bold}"]

# Begin loop of regular and bold
i = 0
while (i < SizeOf(input_list))
  # Open Hack
  Print("Open " + input_list[i])
  Open(input_list[i])

  # powerline extra の記号を残し、残りを削除
  SelectNone()
  ${powerline_symbols}
  ${powerline_extra_symbols}
  SelectInvert()
  Clear()

  SelectWorthOutputting()
  UnlinkReference()
  ScaleToEm(${em_ascent}, ${em_descent})

  Scale(${hack_shrink_x}, ${hack_shrink_y}, 0, 0)

  # 幅の変更 (Move で文字幅も変わることに注意)
  move_pt = $(((${firge_half_width} - ${hack_width} * ${hack_shrink_x} / 100) / 2)) # -8
  width_pt = ${firge_half_width}
  Move(move_pt, 0)
  SetWidth(width_pt, 0)

  # 細かな幅合わせ
  Select(0ue0b0) 
  SelectMore(0ue0b4)
  SelectMore(0ue0b8)
  SelectMore(0ue0bc)
  SelectMore(0ue0c0)
  SelectMore(0ue0c8)
  Move(-15, 0)
  SelectWorthOutputting()
  SetWidth(width_pt, 0)

  # パスの小数点以下を切り捨て
  SelectWorthOutputting()
  RoundToInt()

  # Save modified Hack
  Print("Save " + output_list[i])
  Save("${tmpdir}/" + output_list[i])

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate extraction powerline symbol script for Firge35
########################################

cat > ${tmpdir}/${modified_hack35_powerline_generator} << _EOT_
#!$fontforge_command -script

Print("Generate powerline symbol for Firge35")

# Set parameters
input_list  = ["${input_nerd_patched_hack_regular}",    "${input_nerd_patched_hack_bold}"]
output_list = ["${modified_hack35_powerline_regular}", "${modified_hack35_powerline_bold}"]

# Begin loop of regular and bold
i = 0
while (i < SizeOf(input_list))
  # Open Hack
  Print("Open " + input_list[i])
  Open(input_list[i])

  # powerline extra の記号を残し、残りを削除
  SelectNone()
  ${powerline_symbols}
  ${powerline_extra_symbols}
  SelectInvert()
  Clear()

  SelectWorthOutputting()
  UnlinkReference()
  ScaleToEm(${em_ascent}, ${em_descent})

  # 幅の変更 (Move で文字幅も変わることに注意)
  move_pt = $(((${firge35_half_width} - ${hack_width}) / 2)) # -8
  width_pt = ${firge35_half_width}
  Move(move_pt, 0)
  SetWidth(width_pt, 0)

  # パスの小数点以下を切り捨て
  SelectWorthOutputting()
  RoundToInt()

  # Save modified Hack
  Print("Save " + output_list[i])
  Save("${tmpdir}/" + output_list[i])

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate extraction Nerd Fonts script for Firge
########################################

cat > ${tmpdir}/${modified_firge_nerd_symbol_generator} << _EOT_
#!$fontforge_command -script

Print("Generate Nerd Fonts symbol for Firge")

# Set parameters
input_list  = ["${input_nerd_patched_hack_regular}",    "${input_nerd_patched_hack_bold}"]
output_list = ["${modified_firge_nerd_symbol_regular}", "${modified_firge_nerd_symbol_bold}"]

# Begin loop of regular and bold
i = 0
while (i < SizeOf(input_list))
  # Open Hack
  Print("Open " + input_list[i])
  Open(input_list[i])
  SelectWorthOutputting()
  UnlinkReference()
  ScaleToEm(${em_ascent}, ${em_descent})

  Scale(${hack_shrink_x}, ${hack_shrink_y}, 0, 0)

  # 幅の変更 (Move で文字幅も変わることに注意)
  move_pt = $(((${firge_half_width} - ${hack_width} * ${hack_shrink_x} / 100) / 2)) # -8
  width_pt = ${firge_full_width}
  Move(move_pt, 0)
  SetWidth(width_pt, 0)

  # Nerd Fonts の記号を残し、残りを削除
  SelectNone()
  ${select_nerd_symbols}
  SelectInvert()
  Clear()

  # パスの小数点以下を切り捨て
  SelectWorthOutputting()
  RoundToInt()

  # Save modified Hack
  Print("Save " + output_list[i])
  Save("${tmpdir}/" + output_list[i])

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate extraction Nerd Fonts script for Firge35 symbols
########################################

cat > ${tmpdir}/${modified_firge35_nerd_symbol_generator} << _EOT_
#!$fontforge_command -script

Print("Generate Nerd Fonts symbol for Firge35")

# Set parameters
input_list  = ["${input_nerd_patched_hack_regular}",    "${input_nerd_patched_hack_bold}"]
output_list = ["${modified_firge35_nerd_symbol_regular}", "${modified_firge35_nerd_symbol_bold}"]

# Begin loop of regular and bold
i = 0
while (i < SizeOf(input_list))
  # Open Hack
  Print("Open " + input_list[i])
  Open(input_list[i])
  SelectWorthOutputting()
  UnlinkReference()
  ScaleToEm(${em_ascent}, ${em_descent})

  # 幅の変更 (Move で文字幅も変わることに注意)
  move_pt = $(((${firge35_half_width} - ${hack_width}) / 2)) # -8
  width_pt = ${firge35_full_width}
  Move(move_pt, 0)
  SetWidth(width_pt, 0)

  # Nerd Fonts の記号を残し、残りを削除
  SelectNone()
  ${select_nerd_symbols}
  SelectInvert()
  Clear()

  # パスの小数点以下を切り捨て
  SelectWorthOutputting()
  RoundToInt()

  # Save modified Hack
  Print("Save " + output_list[i])
  Save("${tmpdir}/" + output_list[i])

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate script for box drawing light for Firge
########################################

cat > ${tmpdir}/${modified_hack_box_drawing_light_generator} << _EOT_
#!$fontforge_command -script

Print("Generate box drawing light for Firge")

# Set parameters
input_list  = ["${tmpdir}/${modified_hack_material_regular}", "${tmpdir}/${modified_hack_material_bold}"]
output_list = ["${modified_hack_box_drawing_light_regular}", "${modified_hack_box_drawing_light_bold}"]

# Begin loop of regular and bold
i = 0
while (i < SizeOf(input_list))
  # Open Hack
  Print("Open " + input_list[i])
  Open(input_list[i])
  SelectWorthOutputting()
  UnlinkReference()

  Scale(${hack_shrink_x}, ${hack_shrink_y}, 0, 0)

  # 幅の変更 (Move で文字幅も変わることに注意)
  move_pt = $(((${firge_half_width} - ${hack_width} * ${hack_shrink_x} / 100) / 2)) # -8
  width_pt = ${firge_half_width}
  Move(move_pt, 0)
  SetWidth(width_pt, 0)

  # 特定の記号のみを残し、残りを削除
  SelectNone()
  ${box_drawing_light_symbols}
  SelectInvert()
  Clear()

  # パスの小数点以下を切り捨て
  SelectWorthOutputting()
  RoundToInt()

  # Save modified Hack
  Print("Save " + output_list[i])
  Save("${tmpdir}/" + output_list[i])

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate script for box drawing light from hinting for Firge35
########################################

cat > ${tmpdir}/${modified_hack35_box_drawing_light_generator} << _EOT_
#!$fontforge_command -script

Print("Generate box drawing light for Firge")

# Set parameters
input_list  = ["${tmpdir}/${modified_hack_material_regular}", "${tmpdir}/${modified_hack_material_bold}"]
output_list = ["${modified_hack35_box_drawing_light_regular}", "${modified_hack35_box_drawing_light_bold}"]

# Begin loop of regular and bold
i = 0
while (i < SizeOf(input_list))
  # Open Hack
  Print("Open " + input_list[i])
  Open(input_list[i])
  SelectWorthOutputting()
  UnlinkReference()

  # 幅の変更 (Move で文字幅も変わることに注意)
  move_pt = $(((${firge35_half_width} - ${hack_width}) / 2)) # -8
  width_pt = ${firge35_half_width}
  Move(move_pt, 0)
  SetWidth(width_pt, 0)

  # 特定の記号のみを残し、残りを削除
  SelectNone()
  ${box_drawing_light_symbols}
  SelectInvert()
  Clear()

  # パスの小数点以下を切り捨て
  SelectWorthOutputting()
  RoundToInt()

  # Save modified Hack
  Print("Save " + output_list[i])
  Save("${tmpdir}/" + output_list[i])

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate extraction Nerd Fonts script for Firge Console
########################################

cat > ${tmpdir}/${modified_firge_nerd_console_symbol_generator} << _EOT_
#!$fontforge_command -script

Print("Generate Nerd Fonts symbol for Firge")

# Set parameters
input_list  = ["${input_nerd_patched_hack_regular}",    "${input_nerd_patched_hack_bold}"]
output_list = ["${modified_firge_nerd_console_symbol_regular}", "${modified_firge_nerd_console_symbol_bold}"]

# Begin loop of regular and bold
i = 0
while (i < SizeOf(input_list))
  # Open Hack
  Print("Open " + input_list[i])
  Open(input_list[i])

  # Nerd Fonts の記号を残し、残りを削除
  SelectNone()
  ${select_nerd_symbols}
  SelectInvert()
  Clear()

  SelectWorthOutputting()
  UnlinkReference()
  ScaleToEm(${em_ascent}, ${em_descent})

  Scale(${hack_shrink_x}, ${hack_shrink_y}, 0, 0)

  # 幅の変更 (Move で文字幅も変わることに注意)
  move_pt = $(((${firge_half_width} - ${hack_width} * ${hack_shrink_x} / 100) / 2)) # -8
  width_pt = ${firge_half_width}
  Move(move_pt, 0)
  SetWidth(width_pt, 0)

  # パスの小数点以下を切り捨て
  SelectWorthOutputting()
  RoundToInt()

  # Save modified Hack
  Print("Save " + output_list[i])
  Save("${tmpdir}/" + output_list[i])

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate extraction Nerd Fonts script for Firge35 Console
########################################

cat > ${tmpdir}/${modified_firge35_nerd_console_symbol_generator} << _EOT_
#!$fontforge_command -script

Print("Generate Nerd Fonts symbol for Firge35")

# Set parameters
input_list  = ["${input_nerd_patched_hack_regular}",    "${input_nerd_patched_hack_bold}"]
output_list = ["${modified_firge35_nerd_console_symbol_regular}", "${modified_firge35_nerd_console_symbol_bold}"]

# Begin loop of regular and bold
i = 0
while (i < SizeOf(input_list))
  # Open Hack
  Print("Open " + input_list[i])
  Open(input_list[i])

  # Nerd Fonts の記号を残し、残りを削除
  SelectNone()
  ${select_nerd_symbols}
  SelectInvert()
  Clear()

  SelectWorthOutputting()
  UnlinkReference()
  ScaleToEm(${em_ascent}, ${em_descent})

  Scale(${hack_shrink_x}, ${hack_shrink_y}, 0, 0)

  # 幅の変更 (Move で文字幅も変わることに注意)
  move_pt = $(((${firge35_half_width} - ${hack_width}) / 2)) # -8
  width_pt = ${firge35_half_width}
  Move(move_pt, 0)
  SetWidth(width_pt, 0)

  # パスの小数点以下を切り捨て
  SelectWorthOutputting()
  RoundToInt()

  # Save modified Hack
  Print("Save " + output_list[i])
  Save("${tmpdir}/" + output_list[i])

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate script for modified Hack console
########################################

cat > ${tmpdir}/${modified_hack_console_generator} << _EOT_
#!$fontforge_command -script

Print("Generate modified Hack Console")

# Set parameters
input_list  = ["${tmpdir}/${modified_hack_material_regular}", "${tmpdir}/${modified_hack_material_bold}"]
output_list = ["${modified_hack_console_regular}", "${modified_hack_console_bold}"]

# Begin loop of regular and bold
i = 0
while (i < SizeOf(input_list))
  # Open Hack
  Print("Open " + input_list[i])
  Open(input_list[i])
  SelectWorthOutputting()
  UnlinkReference()

  Scale(${hack_shrink_x}, ${hack_shrink_y}, 0, 0)

  # 幅の変更 (Move で文字幅も変わることに注意)
  move_pt = $(((${firge_half_width} - ${hack_width} * ${hack_shrink_x} / 100) / 2)) # -8
  width_pt = ${firge_half_width}
  Move(move_pt, 0)
  SetWidth(width_pt, 0)

  # ヒンティング回避のため特定記号の削除
  SelectNone()
  ${box_drawing_light_symbols}
  Clear()

  # パスの小数点以下を切り捨て
  SelectWorthOutputting()
  RoundToInt()

  # Save modified Hack
  Print("Save " + output_list[i])
  Save("${tmpdir}/" + output_list[i])

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate script for modified Hack35 console
########################################

cat > ${tmpdir}/${modified_hack35_console_generator} << _EOT_
#!$fontforge_command -script

Print("Generate modified Hack35 Console")

# Set parameters
input_list  = ["${tmpdir}/${modified_hack_material_regular}", "${tmpdir}/${modified_hack_material_bold}"]
output_list = ["${modified_hack35_console_regular}", "${modified_hack35_console_bold}"]

# Begin loop of regular and bold
i = 0
while (i < SizeOf(input_list))
  # Open Hack
  Print("Open " + input_list[i])
  Open(input_list[i])
  SelectWorthOutputting()
  UnlinkReference()

  # 幅の変更 (Move で文字幅も変わることに注意)
  move_pt = $(((${firge35_half_width} - ${hack_width}) / 2)) # -8
  width_pt = ${firge35_half_width}
  Move(move_pt, 0)
  SetWidth(width_pt, 0)

  # ヒンティング回避のため特定記号の削除
  SelectNone()
  ${box_drawing_light_symbols}
  Clear()

  # パスの小数点以下を切り捨て
  SelectWorthOutputting()
  RoundToInt()

  # Save modified Hack
  Print("Save " + output_list[i])
  Save("${tmpdir}/" + output_list[i])

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate script for modified Hack
########################################

cat > ${tmpdir}/${modified_hack_generator} << _EOT_
#!$fontforge_command -script

Print("Generate modified Hack")

# Set parameters
input_list  = ["${tmpdir}/${modified_hack_console_regular}", "${tmpdir}/${modified_hack_console_bold}"]
output_list = ["${modified_hack_regular}", "${modified_hack_bold}"]

# Begin loop of regular and bold
i = 0
while (i < SizeOf(input_list))
  # Open Hack
  Print("Open " + input_list[i])
  Open(input_list[i])

  # Remove ambiguous glyphs
  SelectNone()
  ${select_glyph_is_not_console}
  Clear()

  # Save modified Hack
  Print("Save " + output_list[i])
  Save("${tmpdir}/" + output_list[i])

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate script for modified Hack35
########################################

cat > ${tmpdir}/${modified_hack35_generator} << _EOT_
#!$fontforge_command -script

Print("Generate modified Hack")

# Set parameters
input_list  = ["${tmpdir}/${modified_hack35_console_regular}", "${tmpdir}/${modified_hack35_console_bold}"]
output_list = ["${modified_hack35_regular}", "${modified_hack35_bold}"]

# Begin loop of regular and bold
i = 0
while (i < SizeOf(input_list))
  # Open Hack
  Print("Open " + input_list[i])
  Open(input_list[i])

  # Remove ambiguous glyphs
  SelectNone()
  ${select_glyph_is_not_console}
  Clear()

  # Save modified Hack
  Print("Save " + output_list[i])
  Save("${tmpdir}/" + output_list[i])

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate script for modified GenJyuuGothicL
########################################

cat > ${tmpdir}/${modified_genjyuu_generator} << _EOT_
#!$fontforge_command -script

Print("Generate modified GenJyuuGothicL")

# Set parameters
hack = "${tmpdir}/${modified_hack_regular}"
input_list  = ["${input_genjyuu_regular}",    "${input_genjyuu_bold}"]
improved_legibility_list  = ["${input_improved_legibility_regular}",    "${input_improved_legibility_bold}"]
reiwa_list  = ["${input_reiwa_regular}",    "${input_reiwa_bold}"]
ideographic_space = "$input_ideographic_space"
output_list = ["${modified_genjyuu_regular}", "${modified_genjyuu_bold}"]

fontstyle_list    = ["Regular", "Bold"]
fontweight_list   = [400,       700]
panoseweight_list = [5,         8]

Print("Get trim target glyph from Hack")
Open(hack)
i = 0
end_hack = 65535
hack_exist_glyph_array = Array(end_hack)
while (i < end_hack)
  if (i % 5000 == 0)
    Print("Processing progress: " + i)
  endif
  if (WorthOutputting(i))
    hack_exist_glyph_array[i] = 1
  else
    hack_exist_glyph_array[i] = 0
  endif
  i++
endloop
Close()

# Begin loop of regular and bold
i = 0
while (i < SizeOf(input_list))
  # Open GenJyuuGothicL
  Print("Open " + input_list[i])
  Open(improved_legibility_list[i])
  MergeFonts(reiwa_list[i])
  MergeFonts(ideographic_space)
  MergeFonts(input_list[i])

  SelectWorthOutputting()
  UnlinkReference()
  ScaleToEm(${em_ascent}, ${em_descent})

  ii = 0
  end_genjyuu = end_hack
  halfwidth_array = Array(end_genjyuu)
  i_halfwidth = 0
  Print("Half width check loop start")
  while ( ii < end_genjyuu )
      if ( ii % 5000 == 0 )
        Print("Processing progress: " + ii)
      endif
      if (WorthOutputting(ii))
        Select(ii)
        if (hack_exist_glyph_array[ii] == 1)
          Clear()
        elseif (GlyphInfo("Width")<768)
          halfwidth_array[i_halfwidth] = ii
          i_halfwidth = i_halfwidth + 1
        endif
      endif
      ii = ii + 1
  endloop
  Print("Half width check loop end")

  Print("Full SetWidth start")
  move_pt = $(((${firge_full_width} - ${genjyuu_width}) / 2)) # 26
  width_pt = ${firge_full_width} # 1076
  SelectWorthOutputting()
  ii=0
  while (ii < i_halfwidth)
      SelectFewer(halfwidth_array[ii])
      ii = ii + 1
  endloop
  Move(move_pt, 0)
  SetWidth(width_pt)
  Print("Full SetWidth end")

  SelectNone()

  Print("Half SetWidth start")
  move_pt = $(((${firge_half_width} - ${genjyuu_width} / 2) / 2)) # 13
  width_pt = ${firge_half_width} # 358
  ii=0
  while (ii < i_halfwidth)
      SelectMore(halfwidth_array[ii])
      ii = ii + 1
  endloop
  Move(move_pt, 0)
  SetWidth(width_pt)
  Print("Half SetWidth end")

  # broken bar は Hack ベースにする
  Select(0u00a6); Clear()

  # Edit zenkaku brackets
  Print("Edit zenkaku brackets")
  bracket_move = $((${firge_half_width} / 2 + ${firge_half_width} / 30))
  Select(0uff08); Move(-bracket_move, 0); SetWidth(${firge_full_width}) # (
  Select(0uff09); Move( bracket_move, 0); SetWidth(${firge_full_width}) # )
  Select(0uff3b); Move(-bracket_move, 0); SetWidth(${firge_full_width}) # [
  Select(0uff3d); Move( bracket_move, 0); SetWidth(${firge_full_width}) # ]
  Select(0uff5b); Move(-bracket_move, 0); SetWidth(${firge_full_width}) # {
  Select(0uff5d); Move( bracket_move, 0); SetWidth(${firge_full_width}) # }

  # 全角 ，．‘’“” の調整
  Select(0uff0e);Scale(155) ; SetWidth(${firge_full_width}) # ．
  Select(0uff0c);Scale(145) ; SetWidth(${firge_full_width}) # ，
  Select(0u2018);Scale(145) ; SetWidth(${firge_full_width}) # ‘
  Select(0u2019);Scale(145) ; SetWidth(${firge_full_width}) # ’
  Select(0u201c);Scale(145) ; SetWidth(${firge_full_width}) # “
  Select(0u201d);Scale(145) ; SetWidth(${firge_full_width}) # ”

  # 下限で見切れているグリフの調整
  Select(0uff47); Scale(100, 91) # ｇ
  Select(0uff4a); Scale(100, 91) # ｊ

  # Save modified GenJyuuGothicL
  Print("Save " + output_list[i])
  Save("${tmpdir}/" + output_list[i])
  Close()

  # Open new file
  Print("Generate Genjyuu ttf")
  New()
  # Set encoding to Unicode-bmp
  Reencode("unicode")
  # Set configuration
  SetFontNames("modified-genjyuu" + fontstyle_list[i])
  ScaleToEm(${em_ascent}, ${em_descent})
  SetOS2Value("Weight", fontweight_list[i]) # Book or Bold
  SetOS2Value("Width",                   5) # Medium
  SetOS2Value("FSType",                  0)
  SetOS2Value("VendorID",           "PfEd")
  SetOS2Value("IBMFamily",            2057) # SS Typewriter Gothic
  SetOS2Value("WinAscentIsOffset",       0)
  SetOS2Value("WinDescentIsOffset",      0)
  SetOS2Value("TypoAscentIsOffset",      0)
  SetOS2Value("TypoDescentIsOffset",     0)
  SetOS2Value("HHeadAscentIsOffset",     0)
  SetOS2Value("HHeadDescentIsOffset",    0)
  SetOS2Value("WinAscent",             ${firge_ascent})
  SetOS2Value("WinDescent",            ${firge_descent})
  SetOS2Value("TypoAscent",            ${em_ascent})
  SetOS2Value("TypoDescent",          -${em_descent})
  SetOS2Value("TypoLineGap",           ${typo_line_gap})
  SetOS2Value("HHeadAscent",           ${firge_ascent})
  SetOS2Value("HHeadDescent",         -${firge_descent})
  SetOS2Value("HHeadLineGap",            0)
  SetPanose([2, 11, panoseweight_list[i], 9, 2, 2, 3, 2, 2, 7])

  MergeFonts("${tmpdir}/" + output_list[i])
  Generate("${tmpdir}/" + output_list[i] + ".ttf", "")
  Close()

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate script for modified GenJyuuGothicL for Firge35
########################################

cat > ${tmpdir}/${modified_genjyuu35_generator} << _EOT_
#!$fontforge_command -script

Print("Generate modified GenJyuuGothicL - 35")

# Set parameters
hack = "${tmpdir}/${modified_hack35_regular}"
input_list  = ["${input_genjyuu_regular}",    "${input_genjyuu_bold}"]
improved_legibility_list  = ["${input_improved_legibility_regular}",    "${input_improved_legibility_bold}"]
reiwa_list  = ["${input_reiwa_regular}",    "${input_reiwa_bold}"]
ideographic_space = "$input_ideographic_space"
output_list = ["${modified_genjyuu35_regular}", "${modified_genjyuu35_bold}"]

fontstyle_list    = ["Regular", "Bold"]
fontweight_list   = [400,       700]
panoseweight_list = [5,         8]

Print("Get trim target glyph from Hack")
Open(hack)
i = 0
end_hack = 65535
hack_exist_glyph_array = Array(end_hack)
while (i < end_hack)
  if (i % 5000 == 0)
    Print("Processing progress: " + i)
  endif
  if (WorthOutputting(i))
    hack_exist_glyph_array[i] = 1
  else
    hack_exist_glyph_array[i] = 0
  endif
  i++
endloop
Close()

# Begin loop of regular and bold
i = 0
while (i < SizeOf(input_list))
  # Open GenJyuuGothicL
  Print("Open " + input_list[i])
  Open(improved_legibility_list[i])
  MergeFonts(reiwa_list[i])
  MergeFonts(ideographic_space)
  MergeFonts(input_list[i])
  SelectWorthOutputting()
  UnlinkReference()
  ScaleToEm(${em_ascent}, ${em_descent})

  ii = 0
  end_genjyuu = end_hack
  halfwidth_array = Array(end_genjyuu)
  i_halfwidth = 0
  Print("Half width check loop start")
  while ( ii < end_genjyuu )
      if ( ii % 5000 == 0 )
        Print("Processing progress: " + ii)
      endif
      if (WorthOutputting(ii))
        Select(ii)
        if (hack_exist_glyph_array[ii] == 1)
          Clear()
        elseif (GlyphInfo("Width")<768)
          halfwidth_array[i_halfwidth] = ii
          i_halfwidth = i_halfwidth + 1
        endif
      endif
      ii = ii + 1
  endloop
  Print("Half width check loop end")

  Print("Full SetWidth start")
  move_pt = $(((${firge35_full_width} - ${genjyuu_width}) / 2)) # 3
  width_pt = ${firge35_full_width} # 1030
  SelectWorthOutputting()
  ii=0
  while (ii < i_halfwidth)
      SelectFewer(halfwidth_array[ii])
      ii = ii + 1
  endloop
  Move(move_pt, 0)
  SetWidth(width_pt)
  Print("Full SetWidth end")

  SelectNone()

  Print("Half SetWidth start")
  move_pt = $(((${firge35_half_width} - ${genjyuu_width} / 2) / 2)) # 35
  width_pt = ${firge35_half_width} # 618
  ii=0
  while (ii < i_halfwidth)
      SelectMore(halfwidth_array[ii])
      ii = ii + 1
  endloop
  Move(move_pt, 0)
  SetWidth(width_pt)
  Print("Half SetWidth end")

  # broken bar は Hack ベースにする
  Select(0u00a6); Clear()

  # Edit zenkaku brackets
  Print("Edit zenkaku brackets")
  bracket_move = $((${firge35_half_width} / 2 + ${firge35_half_width} / 30))
  Select(0uff08); Move(-bracket_move, 0); SetWidth(${firge35_full_width}) # (
  Select(0uff09); Move( bracket_move, 0); SetWidth(${firge35_full_width}) # )
  Select(0uff3b); Move(-bracket_move, 0); SetWidth(${firge35_full_width}) # [
  Select(0uff3d); Move( bracket_move, 0); SetWidth(${firge35_full_width}) # ]
  Select(0uff5b); Move(-bracket_move, 0); SetWidth(${firge35_full_width}) # {
  Select(0uff5d); Move( bracket_move, 0); SetWidth(${firge35_full_width}) # }

  # 全角 ，．‘’“” の調整
  Select(0uff0e);Scale(155) ; SetWidth(${firge35_full_width}) # ．
  Select(0uff0c);Scale(145) ; SetWidth(${firge35_full_width}) # ，
  Select(0u2018);Scale(145) ; SetWidth(${firge35_full_width}) # ‘
  Select(0u2019);Scale(145) ; SetWidth(${firge35_full_width}) # ’
  Select(0u201c);Scale(145) ; SetWidth(${firge35_full_width}) # “
  Select(0u201d);Scale(145) ; SetWidth(${firge35_full_width}) # ”

  # Save modified GenJyuuGothicL
  Print("Save " + output_list[i])
  Save("${tmpdir}/" + output_list[i])
  Close()

  # Open new file
  Print("Generate Genjyuu ttf")
  New()
  # Set encoding to Unicode-bmp
  Reencode("unicode")
  # Set configuration
  SetFontNames("modified-genjyuu" + fontstyle_list[i])
  ScaleToEm(${em_ascent}, ${em_descent})
  SetOS2Value("Weight", fontweight_list[i]) # Book or Bold
  SetOS2Value("Width",                   5) # Medium
  SetOS2Value("FSType",                  0)
  SetOS2Value("VendorID",           "PfEd")
  SetOS2Value("IBMFamily",            2057) # SS Typewriter Gothic
  SetOS2Value("WinAscentIsOffset",       0)
  SetOS2Value("WinDescentIsOffset",      0)
  SetOS2Value("TypoAscentIsOffset",      0)
  SetOS2Value("TypoDescentIsOffset",     0)
  SetOS2Value("HHeadAscentIsOffset",     0)
  SetOS2Value("HHeadDescentIsOffset",    0)
  SetOS2Value("WinAscent",             ${firge35_ascent})
  SetOS2Value("WinDescent",            ${firge35_descent})
  SetOS2Value("TypoAscent",            ${em_ascent})
  SetOS2Value("TypoDescent",          -${em_descent})
  SetOS2Value("TypoLineGap",           ${typo_line_gap})
  SetOS2Value("HHeadAscent",           ${firge35_ascent})
  SetOS2Value("HHeadDescent",         -${firge35_descent})
  SetOS2Value("HHeadLineGap",            0)
  SetPanose([2, 11, panoseweight_list[i], 9, 2, 2, 3, 2, 2, 7])

  MergeFonts("${tmpdir}/" + output_list[i])
  Generate("${tmpdir}/" + output_list[i] + ".ttf", "")
  Close()

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate script for modified GenJyuuGothicL Console
########################################

cat > ${tmpdir}/${modified_genjyuu_console_generator} << _EOT_
#!$fontforge_command -script

Print("Generate modified GenJyuuGothicL Console")

# Set parameters
hack = "${tmpdir}/${modified_hack_material_regular}"
input_list  = ["${tmpdir}/${modified_genjyuu_regular}.ttf", "${tmpdir}/${modified_genjyuu_bold}.ttf"]
output_list = ["${modified_genjyuu_console_regular}", "${modified_genjyuu_console_bold}"]

Print("Get trim target glyph from Hack")
Open(hack)
i = 0
end_hack = 65535
hack_exist_glyph_array = Array(end_hack)
while (i < end_hack)
  if (i % 5000 == 0)
    Print("Processing progress: " + i)
  endif
  if (WorthOutputting(i))
    hack_exist_glyph_array[i] = 1
  else
    hack_exist_glyph_array[i] = 0
  endif
  i++
endloop
Close()

# Begin loop of regular and bold
i = 0
while (i < SizeOf(input_list))
  # Open GenJyuuGothicL
  Print("Open " + input_list[i])
  Open(input_list[i])

  ii = 0
  end_genjyuu = end_hack
  Print("Begin delete the glyphs contained in Hack")
  SelectNone()
  ${box_drawing_light_symbols}
  while ( ii < end_genjyuu )
      if ( ii % 5000 == 0 )
        Print("Processing progress: " + ii)
      endif
      if (WorthOutputting(ii) && hack_exist_glyph_array[ii] == 1)
        SelectMore(ii)
      endif
      ii = ii + 1
  endloop
  Clear()
  Print("End delete the glyphs contained in Hack")

  # 結合分音記号は全て源柔ゴシック収録のものを使用する
  Select(0u0300, 0u036f)
  move_pt = $(((${firge_half_width} - ${firge_full_width}) / 2))
  Move(move_pt, 0)
  SetWidth(${firge_half_width}, 0)

  # Save modified GenJyuuGothicL
  Print("Generate " + output_list[i])
  Generate("${tmpdir}/" + output_list[i] + ".ttf", "")
  Close()

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate script for modified GenJyuuGothicL Console for Firge35
########################################

cat > ${tmpdir}/${modified_genjyuu35_console_generator} << _EOT_
#!$fontforge_command -script

Print("Generate modified GenJyuuGothicL Console - 35")

# Set parameters
hack = "${tmpdir}/${modified_hack_material_regular}"
input_list  = ["${tmpdir}/${modified_genjyuu35_regular}.ttf", "${tmpdir}/${modified_genjyuu35_bold}.ttf"]
output_list = ["${modified_genjyuu35_console_regular}", "${modified_genjyuu35_console_bold}"]

Print("Get trim target glyph from Hack")
Open(hack)
i = 0
end_hack = 65535
hack_exist_glyph_array = Array(end_hack)
while (i < end_hack)
  if (i % 5000 == 0)
    Print("Processing progress: " + i)
  endif
  if (WorthOutputting(i))
    hack_exist_glyph_array[i] = 1
  else
    hack_exist_glyph_array[i] = 0
  endif
  i++
endloop
Close()

# Begin loop of regular and bold
i = 0
while (i < SizeOf(input_list))
  # Open GenJyuuGothicL
  Print("Open " + input_list[i])
  Open(input_list[i])

  ii = 0
  end_genjyuu = end_hack
  Print("Begin delete the glyphs contained in Hack")
  SelectNone()
  ${box_drawing_light_symbols}
  while ( ii < end_genjyuu )
      if ( ii % 5000 == 0 )
        Print("Processing progress: " + ii)
      endif
      if (WorthOutputting(ii) && hack_exist_glyph_array[ii] == 1)
        SelectMore(ii)
      endif
      ii = ii + 1
  endloop
  Clear()
  Print("End delete the glyphs contained in Hack")

  # 結合分音記号は全て源柔ゴシック収録のものを使用する
  Select(0u0300, 0u036f)
  move_pt = $(((${firge35_half_width} - ${firge35_full_width}) / 2))
  Move(move_pt, 0)
  SetWidth(${firge35_half_width}, 0)

  # Save modified GenJyuuGothicL
  Print("Generate " + output_list[i])
  Generate("${tmpdir}/" + output_list[i] + ".ttf", "")
  Close()

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate script for Firge
########################################

cat > ${tmpdir}/${firge_generator} << _EOT_
#!$fontforge_command -script

# Print message
Print("Generate Firge")

# Set parameters
hack_list  = ["${tmpdir}/${modified_hack_regular}", \\
                     "${tmpdir}/${modified_hack_bold}"]
fontfamily        = "${firge_familyname}"
fontfamilysuffix  = "${firge_familyname_suffix}"
fontstyle_list    = ["Regular", "Bold"]
fontweight_list   = [400,       700]
panoseweight_list = [5,         8]
copyright         = "${copyright}"
version           = "${firge_version}"

# Begin loop of regular and bold
i = 0
while (i < SizeOf(fontstyle_list))
  # Open new file
  New()

  # Set encoding to Unicode-bmp
  Reencode("unicode")

  # Set configuration
  if (fontfamilysuffix != "")
        SetFontNames(fontfamily + fontfamilysuffix + "-" + fontstyle_list[i], \\
                     fontfamily + " " + fontfamilysuffix, \\
                     fontfamily + " " + fontfamilysuffix + " " + fontstyle_list[i], \\
                     fontstyle_list[i], \\
                     copyright, version)
  else
        SetFontNames(fontfamily + "-" + fontstyle_list[i], \\
                     fontfamily, \\
                     fontfamily + " " + fontstyle_list[i], \\
                     fontstyle_list[i], \\
                     copyright, version)
  endif
  SetTTFName(0x409, 2, fontstyle_list[i])
  SetTTFName(0x409, 3, "FontForge 2.0 : " + \$fullname + " : " + Strftime("%d-%m-%Y", 0))
  ScaleToEm(${em_ascent}, ${em_descent})
  SetOS2Value("Weight", fontweight_list[i]) # Book or Bold
  SetOS2Value("Width",                   5) # Medium
  SetOS2Value("FSType",                  0)
  SetOS2Value("VendorID",           "PfEd")
  SetOS2Value("IBMFamily",            2057) # SS Typewriter Gothic
  SetOS2Value("WinAscentIsOffset",       0)
  SetOS2Value("WinDescentIsOffset",      0)
  SetOS2Value("TypoAscentIsOffset",      0)
  SetOS2Value("TypoDescentIsOffset",     0)
  SetOS2Value("HHeadAscentIsOffset",     0)
  SetOS2Value("HHeadDescentIsOffset",    0)
  SetOS2Value("WinAscent",             ${firge_ascent})
  SetOS2Value("WinDescent",            ${firge_descent})
  SetOS2Value("TypoAscent",            ${em_ascent})
  SetOS2Value("TypoDescent",          -${em_descent})
  SetOS2Value("TypoLineGap",           ${typo_line_gap})
  SetOS2Value("HHeadAscent",           ${firge_ascent})
  SetOS2Value("HHeadDescent",         -${firge_descent})
  SetOS2Value("HHeadLineGap",            0)
  SetPanose([2, 11, panoseweight_list[i], 9, 2, 2, 3, 2, 2, 7])

  # Merge Hack font
  Print("Merge " + hack_list[i]:t)
  MergeFonts(hack_list[i])

  # Save Firge
  if (fontfamilysuffix != "")
        Print("Save " + fontfamily + fontfamilysuffix + "-" + fontstyle_list[i] + ".ttf")
        Generate("${base_dir}/" + fontfamily + fontfamilysuffix + "-" + fontstyle_list[i] + ".ttf", "")
  else
        Print("Save " + fontfamily + "-" + fontstyle_list[i] + ".ttf")
        Generate("${base_dir}/" + fontfamily + "-" + fontstyle_list[i] + ".ttf", "")
  endif
  Close()

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate extraction nerd symbols script for Firge
########################################

cat > ${tmpdir}/${firge_nerd_symbol_generator} << _EOT_
#!$fontforge_command -script

# Print message
Print("Generate extraction nerd symbols script for Firge")

# Set parameters
hack_list  = ["${tmpdir}/${modified_firge_nerd_symbol_regular}", \\
                     "${tmpdir}/${modified_firge_nerd_symbol_bold}"]
powerline_list = ["${tmpdir}/${modified_hack_powerline_regular}", \\
                      "${tmpdir}/${modified_hack_powerline_bold}"]
fontfamily        = "${firge_evacuation_nerd_familyname}"
fontfamilysuffix  = "${firge_familyname_suffix}"
fontstyle_list    = ["Regular", "Bold"]
fontweight_list   = [400,       700]
panoseweight_list = [5,         8]
copyright         = "${copyright}"
version           = "${firge_version}"

# Begin loop of regular and bold
i = 0
while (i < SizeOf(fontstyle_list))
  # Open new file
  New()

  # Set encoding to Unicode-bmp
  Reencode("unicode")

  # Set configuration
  if (fontfamilysuffix != "")
        SetFontNames(fontfamily + fontfamilysuffix + "-" + fontstyle_list[i], \\
                     fontfamily + " " + fontfamilysuffix, \\
                     fontfamily + " " + fontfamilysuffix + " " + fontstyle_list[i], \\
                     fontstyle_list[i], \\
                     copyright, version)
  else
        SetFontNames(fontfamily + "-" + fontstyle_list[i], \\
                     fontfamily, \\
                     fontfamily + " " + fontstyle_list[i], \\
                     fontstyle_list[i], \\
                     copyright, version)
  endif
  SetTTFName(0x409, 2, fontstyle_list[i])
  SetTTFName(0x409, 3, "FontForge 2.0 : " + \$fullname + " : " + Strftime("%d-%m-%Y", 0))
  ScaleToEm(${em_ascent}, ${em_descent})
  SetOS2Value("Weight", fontweight_list[i]) # Book or Bold
  SetOS2Value("Width",                   5) # Medium
  SetOS2Value("FSType",                  0)
  SetOS2Value("VendorID",           "PfEd")
  SetOS2Value("IBMFamily",            2057) # SS Typewriter Gothic
  SetOS2Value("WinAscentIsOffset",       0)
  SetOS2Value("WinDescentIsOffset",      0)
  SetOS2Value("TypoAscentIsOffset",      0)
  SetOS2Value("TypoDescentIsOffset",     0)
  SetOS2Value("HHeadAscentIsOffset",     0)
  SetOS2Value("HHeadDescentIsOffset",    0)
  SetOS2Value("WinAscent",             ${firge_ascent})
  SetOS2Value("WinDescent",            ${firge_descent})
  SetOS2Value("TypoAscent",            ${em_ascent})
  SetOS2Value("TypoDescent",          -${em_descent})
  SetOS2Value("TypoLineGap",           ${typo_line_gap})
  SetOS2Value("HHeadAscent",           ${firge_ascent})
  SetOS2Value("HHeadDescent",         -${firge_descent})
  SetOS2Value("HHeadLineGap",            0)
  SetPanose([2, 11, panoseweight_list[i], 9, 2, 2, 3, 2, 2, 7])

  # Merge Hack font
  Print("Merge " + hack_list[i]:t)
  MergeFonts(hack_list[i])
  MergeFonts(powerline_list[i])

  # Save Firge
  if (fontfamilysuffix != "")
        Print("Save " + fontfamily + fontfamilysuffix + "-" + fontstyle_list[i] + ".ttf")
        Generate("${base_dir}/" + fontfamily + fontfamilysuffix + "-" + fontstyle_list[i] + ".ttf", "")
  else
        Print("Save " + fontfamily + "-" + fontstyle_list[i] + ".ttf")
        Generate("${base_dir}/" + fontfamily + "-" + fontstyle_list[i] + ".ttf", "")
  endif
  Close()

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate extraction nerd symbols script for Firge35
########################################

cat > ${tmpdir}/${firge35_nerd_symbol_generator} << _EOT_
#!$fontforge_command -script

# Print message
Print("Generate extraction nerd symbols script for Firge35")

# Set parameters
hack_list  = ["${tmpdir}/${modified_firge35_nerd_symbol_regular}", \\
                     "${tmpdir}/${modified_firge35_nerd_symbol_bold}"]
powerline_list = ["${tmpdir}/${modified_hack35_powerline_regular}", \\
                      "${tmpdir}/${modified_hack35_powerline_bold}"]
fontfamily        = "${firge35_evacuation_nerd_familyname}"
fontfamilysuffix  = "${firge35_familyname_suffix}"
fontstyle_list    = ["Regular", "Bold"]
fontweight_list   = [400,       700]
panoseweight_list = [5,         8]
copyright         = "${copyright}"
version           = "${firge_version}"

# Begin loop of regular and bold
i = 0
while (i < SizeOf(fontstyle_list))
  # Open new file
  New()

  # Set encoding to Unicode-bmp
  Reencode("unicode")

  # Set configuration
  if (fontfamilysuffix != "")
        SetFontNames(fontfamily + fontfamilysuffix + "-" + fontstyle_list[i], \\
                     fontfamily + " " + fontfamilysuffix, \\
                     fontfamily + " " + fontfamilysuffix + " " + fontstyle_list[i], \\
                     fontstyle_list[i], \\
                     copyright, version)
  else
        SetFontNames(fontfamily + "-" + fontstyle_list[i], \\
                     fontfamily, \\
                     fontfamily + " " + fontstyle_list[i], \\
                     fontstyle_list[i], \\
                     copyright, version)
  endif
  SetTTFName(0x409, 2, fontstyle_list[i])
  SetTTFName(0x409, 3, "FontForge 2.0 : " + \$fullname + " : " + Strftime("%d-%m-%Y", 0))
  ScaleToEm(${em_ascent}, ${em_descent})
  SetOS2Value("Weight", fontweight_list[i]) # Book or Bold
  SetOS2Value("Width",                   5) # Medium
  SetOS2Value("FSType",                  0)
  SetOS2Value("VendorID",           "PfEd")
  SetOS2Value("IBMFamily",            2057) # SS Typewriter Gothic
  SetOS2Value("WinAscentIsOffset",       0)
  SetOS2Value("WinDescentIsOffset",      0)
  SetOS2Value("TypoAscentIsOffset",      0)
  SetOS2Value("TypoDescentIsOffset",     0)
  SetOS2Value("HHeadAscentIsOffset",     0)
  SetOS2Value("HHeadDescentIsOffset",    0)
  SetOS2Value("WinAscent",             ${firge35_ascent})
  SetOS2Value("WinDescent",            ${firge35_descent})
  SetOS2Value("TypoAscent",            ${em_ascent})
  SetOS2Value("TypoDescent",          -${em_descent})
  SetOS2Value("TypoLineGap",           ${typo_line_gap})
  SetOS2Value("HHeadAscent",           ${firge35_ascent})
  SetOS2Value("HHeadDescent",         -${firge35_descent})
  SetOS2Value("HHeadLineGap",            0)
  SetPanose([2, 11, panoseweight_list[i], 9, 2, 2, 3, 2, 2, 7])

  # Merge Hack font
  Print("Merge " + hack_list[i]:t)
  MergeFonts(hack_list[i])
  MergeFonts(powerline_list[i])

  # Save Firge
  if (fontfamilysuffix != "")
        Print("Save " + fontfamily + fontfamilysuffix + "-" + fontstyle_list[i] + ".ttf")
        Generate("${base_dir}/" + fontfamily + fontfamilysuffix + "-" + fontstyle_list[i] + ".ttf", "")
  else
        Print("Save " + fontfamily + "-" + fontstyle_list[i] + ".ttf")
        Generate("${base_dir}/" + fontfamily + "-" + fontstyle_list[i] + ".ttf", "")
  endif
  Close()

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate extraction nerd symbols script for Firge Console
########################################

cat > ${tmpdir}/${firge_nerd_console_symbol_generator} << _EOT_
#!$fontforge_command -script

# Print message
Print("Generate extraction nerd symbols script for Firge")

# Set parameters
hack_list  = ["${tmpdir}/${modified_firge_nerd_console_symbol_regular}", \\
                     "${tmpdir}/${modified_firge_nerd_console_symbol_bold}"]
powerline_list = ["${tmpdir}/${modified_hack_powerline_regular}", \\
                      "${tmpdir}/${modified_hack_powerline_bold}"]
fontfamily        = "${firge_evacuation_nerd_familyname}"
fontfamilysuffix  = "${firge_console_suffix}"
fontstyle_list    = ["Regular", "Bold"]
fontweight_list   = [400,       700]
panoseweight_list = [5,         8]
copyright         = "${copyright}"
version           = "${firge_version}"

# Begin loop of regular and bold
i = 0
while (i < SizeOf(fontstyle_list))
  # Open new file
  New()

  # Set encoding to Unicode-bmp
  Reencode("unicode")

  # Set configuration
  if (fontfamilysuffix != "")
        SetFontNames(fontfamily + fontfamilysuffix + "-" + fontstyle_list[i], \\
                     fontfamily + " " + fontfamilysuffix, \\
                     fontfamily + " " + fontfamilysuffix + " " + fontstyle_list[i], \\
                     fontstyle_list[i], \\
                     copyright, version)
  else
        SetFontNames(fontfamily + "-" + fontstyle_list[i], \\
                     fontfamily, \\
                     fontfamily + " " + fontstyle_list[i], \\
                     fontstyle_list[i], \\
                     copyright, version)
  endif
  SetTTFName(0x409, 2, fontstyle_list[i])
  SetTTFName(0x409, 3, "FontForge 2.0 : " + \$fullname + " : " + Strftime("%d-%m-%Y", 0))
  ScaleToEm(${em_ascent}, ${em_descent})
  SetOS2Value("Weight", fontweight_list[i]) # Book or Bold
  SetOS2Value("Width",                   5) # Medium
  SetOS2Value("FSType",                  0)
  SetOS2Value("VendorID",           "PfEd")
  SetOS2Value("IBMFamily",            2057) # SS Typewriter Gothic
  SetOS2Value("WinAscentIsOffset",       0)
  SetOS2Value("WinDescentIsOffset",      0)
  SetOS2Value("TypoAscentIsOffset",      0)
  SetOS2Value("TypoDescentIsOffset",     0)
  SetOS2Value("HHeadAscentIsOffset",     0)
  SetOS2Value("HHeadDescentIsOffset",    0)
  SetOS2Value("WinAscent",             ${firge_ascent})
  SetOS2Value("WinDescent",            ${firge_descent})
  SetOS2Value("TypoAscent",            ${em_ascent})
  SetOS2Value("TypoDescent",          -${em_descent})
  SetOS2Value("TypoLineGap",           ${typo_line_gap})
  SetOS2Value("HHeadAscent",           ${firge_ascent})
  SetOS2Value("HHeadDescent",         -${firge_descent})
  SetOS2Value("HHeadLineGap",            0)
  SetPanose([2, 11, panoseweight_list[i], 9, 2, 2, 3, 2, 2, 7])

  # Merge Hack font
  Print("Merge " + hack_list[i]:t)
  MergeFonts(hack_list[i])
  MergeFonts(powerline_list[i])

  # Save Firge
  if (fontfamilysuffix != "")
        Print("Save " + fontfamily + fontfamilysuffix + "-" + fontstyle_list[i] + ".ttf")
        Generate("${base_dir}/" + fontfamily + fontfamilysuffix + "-" + fontstyle_list[i] + ".ttf", "")
  else
        Print("Save " + fontfamily + "-" + fontstyle_list[i] + ".ttf")
        Generate("${base_dir}/" + fontfamily + "-" + fontstyle_list[i] + ".ttf", "")
  endif
  Close()

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate extraction nerd symbols script for Firge35 Console
########################################

cat > ${tmpdir}/${firge35_nerd_console_symbol_generator} << _EOT_
#!$fontforge_command -script

# Print message
Print("Generate extraction nerd symbols script for Firge35")

# Set parameters
hack_list  = ["${tmpdir}/${modified_firge35_nerd_console_symbol_regular}", \\
                     "${tmpdir}/${modified_firge35_nerd_console_symbol_bold}"]
powerline_list = ["${tmpdir}/${modified_hack35_powerline_regular}", \\
                      "${tmpdir}/${modified_hack35_powerline_bold}"]
fontfamily        = "${firge35_evacuation_nerd_familyname}"
fontfamilysuffix  = "${firge_console_suffix}"
fontstyle_list    = ["Regular", "Bold"]
fontweight_list   = [400,       700]
panoseweight_list = [5,         8]
copyright         = "${copyright}"
version           = "${firge_version}"

# Begin loop of regular and bold
i = 0
while (i < SizeOf(fontstyle_list))
  # Open new file
  New()

  # Set encoding to Unicode-bmp
  Reencode("unicode")

  # Set configuration
  if (fontfamilysuffix != "")
        SetFontNames(fontfamily + fontfamilysuffix + "-" + fontstyle_list[i], \\
                     fontfamily + " " + fontfamilysuffix, \\
                     fontfamily + " " + fontfamilysuffix + " " + fontstyle_list[i], \\
                     fontstyle_list[i], \\
                     copyright, version)
  else
        SetFontNames(fontfamily + "-" + fontstyle_list[i], \\
                     fontfamily, \\
                     fontfamily + " " + fontstyle_list[i], \\
                     fontstyle_list[i], \\
                     copyright, version)
  endif
  SetTTFName(0x409, 2, fontstyle_list[i])
  SetTTFName(0x409, 3, "FontForge 2.0 : " + \$fullname + " : " + Strftime("%d-%m-%Y", 0))
  ScaleToEm(${em_ascent}, ${em_descent})
  SetOS2Value("Weight", fontweight_list[i]) # Book or Bold
  SetOS2Value("Width",                   5) # Medium
  SetOS2Value("FSType",                  0)
  SetOS2Value("VendorID",           "PfEd")
  SetOS2Value("IBMFamily",            2057) # SS Typewriter Gothic
  SetOS2Value("WinAscentIsOffset",       0)
  SetOS2Value("WinDescentIsOffset",      0)
  SetOS2Value("TypoAscentIsOffset",      0)
  SetOS2Value("TypoDescentIsOffset",     0)
  SetOS2Value("HHeadAscentIsOffset",     0)
  SetOS2Value("HHeadDescentIsOffset",    0)
  SetOS2Value("WinAscent",             ${firge35_ascent})
  SetOS2Value("WinDescent",            ${firge35_descent})
  SetOS2Value("TypoAscent",            ${em_ascent})
  SetOS2Value("TypoDescent",          -${em_descent})
  SetOS2Value("TypoLineGap",           ${typo_line_gap})
  SetOS2Value("HHeadAscent",           ${firge35_ascent})
  SetOS2Value("HHeadDescent",         -${firge35_descent})
  SetOS2Value("HHeadLineGap",            0)
  SetPanose([2, 11, panoseweight_list[i], 9, 2, 2, 3, 2, 2, 7])

  # Merge Hack font
  Print("Merge " + hack_list[i]:t)
  MergeFonts(hack_list[i])
  MergeFonts(powerline_list[i])

  # Save Firge
  if (fontfamilysuffix != "")
        Print("Save " + fontfamily + fontfamilysuffix + "-" + fontstyle_list[i] + ".ttf")
        Generate("${base_dir}/" + fontfamily + fontfamilysuffix + "-" + fontstyle_list[i] + ".ttf", "")
  else
        Print("Save " + fontfamily + "-" + fontstyle_list[i] + ".ttf")
        Generate("${base_dir}/" + fontfamily + "-" + fontstyle_list[i] + ".ttf", "")
  endif
  Close()

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate extraction evacuation symbol from hinting for Firge
########################################

cat > ${tmpdir}/${firge_evacuate_from_hinting_generator} << _EOT_
#!$fontforge_command -script

# Print message
Print("Generate extraction evacuation symbol from hinting for Firge")

# Set parameters
hack_list  = ["${tmpdir}/${modified_hack_evacuate_from_hinting_regular}", \\
                     "${tmpdir}/${modified_hack_evacuate_from_hinting_bold}"]
fontfamily        = "${firge_evacuation_symbol_familyname}"
fontfamilysuffix  = "${firge_familyname_suffix}"
fontstyle_list    = ["Regular", "Bold"]
fontweight_list   = [400,       700]
panoseweight_list = [5,         8]
copyright         = "${copyright}"
version           = "${firge_version}"

# Begin loop of regular and bold
i = 0
while (i < SizeOf(fontstyle_list))
  # Open new file
  New()

  # Set encoding to Unicode-bmp
  Reencode("unicode")

  # Set configuration
  if (fontfamilysuffix != "")
        SetFontNames(fontfamily + fontfamilysuffix + "-" + fontstyle_list[i], \\
                     fontfamily + " " + fontfamilysuffix, \\
                     fontfamily + " " + fontfamilysuffix + " " + fontstyle_list[i], \\
                     fontstyle_list[i], \\
                     copyright, version)
  else
        SetFontNames(fontfamily + "-" + fontstyle_list[i], \\
                     fontfamily, \\
                     fontfamily + " " + fontstyle_list[i], \\
                     fontstyle_list[i], \\
                     copyright, version)
  endif
  SetTTFName(0x409, 2, fontstyle_list[i])
  SetTTFName(0x409, 3, "FontForge 2.0 : " + \$fullname + " : " + Strftime("%d-%m-%Y", 0))
  ScaleToEm(${em_ascent}, ${em_descent})
  SetOS2Value("Weight", fontweight_list[i]) # Book or Bold
  SetOS2Value("Width",                   5) # Medium
  SetOS2Value("FSType",                  0)
  SetOS2Value("VendorID",           "PfEd")
  SetOS2Value("IBMFamily",            2057) # SS Typewriter Gothic
  SetOS2Value("WinAscentIsOffset",       0)
  SetOS2Value("WinDescentIsOffset",      0)
  SetOS2Value("TypoAscentIsOffset",      0)
  SetOS2Value("TypoDescentIsOffset",     0)
  SetOS2Value("HHeadAscentIsOffset",     0)
  SetOS2Value("HHeadDescentIsOffset",    0)
  SetOS2Value("WinAscent",             ${firge_ascent})
  SetOS2Value("WinDescent",            ${firge_descent})
  SetOS2Value("TypoAscent",            ${em_ascent})
  SetOS2Value("TypoDescent",          -${em_descent})
  SetOS2Value("TypoLineGap",           ${typo_line_gap})
  SetOS2Value("HHeadAscent",           ${firge_ascent})
  SetOS2Value("HHeadDescent",         -${firge_descent})
  SetOS2Value("HHeadLineGap",            0)
  SetPanose([2, 11, panoseweight_list[i], 9, 2, 2, 3, 2, 2, 7])

  # Merge Hack font
  Print("Merge " + hack_list[i]:t)
  MergeFonts(hack_list[i])

  # Save Firge
  if (fontfamilysuffix != "")
        Print("Save " + fontfamily + fontfamilysuffix + "-" + fontstyle_list[i] + ".ttf")
        Generate("${base_dir}/" + fontfamily + fontfamilysuffix + "-" + fontstyle_list[i] + ".ttf", "")
  else
        Print("Save " + fontfamily + "-" + fontstyle_list[i] + ".ttf")
        Generate("${base_dir}/" + fontfamily + "-" + fontstyle_list[i] + ".ttf", "")
  endif
  Close()

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate extraction evacuation symbol from hinting for Firge35
########################################

cat > ${tmpdir}/${firge35_evacuate_from_hinting_generator} << _EOT_
#!$fontforge_command -script

# Print message
Print("Generate extraction evacuation symbol from hinting for Firge35")

# Set parameters
hack_list  = ["${tmpdir}/${modified_hack35_evacuate_from_hinting_regular}", \\
                     "${tmpdir}/${modified_hack35_evacuate_from_hinting_bold}"]
fontfamily        = "${firge35_evacuation_symbol_familyname}"
fontfamilysuffix  = "${firge_familyname_suffix}"
fontstyle_list    = ["Regular", "Bold"]
fontweight_list   = [400,       700]
panoseweight_list = [5,         8]
copyright         = "${copyright}"
version           = "${firge_version}"

# Begin loop of regular and bold
i = 0
while (i < SizeOf(fontstyle_list))
  # Open new file
  New()

  # Set encoding to Unicode-bmp
  Reencode("unicode")

  # Set configuration
  if (fontfamilysuffix != "")
        SetFontNames(fontfamily + fontfamilysuffix + "-" + fontstyle_list[i], \\
                     fontfamily + " " + fontfamilysuffix, \\
                     fontfamily + " " + fontfamilysuffix + " " + fontstyle_list[i], \\
                     fontstyle_list[i], \\
                     copyright, version)
  else
        SetFontNames(fontfamily + "-" + fontstyle_list[i], \\
                     fontfamily, \\
                     fontfamily + " " + fontstyle_list[i], \\
                     fontstyle_list[i], \\
                     copyright, version)
  endif
  SetTTFName(0x409, 2, fontstyle_list[i])
  SetTTFName(0x409, 3, "FontForge 2.0 : " + \$fullname + " : " + Strftime("%d-%m-%Y", 0))
  ScaleToEm(${em_ascent}, ${em_descent})
  SetOS2Value("Weight", fontweight_list[i]) # Book or Bold
  SetOS2Value("Width",                   5) # Medium
  SetOS2Value("FSType",                  0)
  SetOS2Value("VendorID",           "PfEd")
  SetOS2Value("IBMFamily",            2057) # SS Typewriter Gothic
  SetOS2Value("WinAscentIsOffset",       0)
  SetOS2Value("WinDescentIsOffset",      0)
  SetOS2Value("TypoAscentIsOffset",      0)
  SetOS2Value("TypoDescentIsOffset",     0)
  SetOS2Value("HHeadAscentIsOffset",     0)
  SetOS2Value("HHeadDescentIsOffset",    0)
  SetOS2Value("WinAscent",             ${firge35_ascent})
  SetOS2Value("WinDescent",            ${firge35_descent})
  SetOS2Value("TypoAscent",            ${em_ascent})
  SetOS2Value("TypoDescent",          -${em_descent})
  SetOS2Value("TypoLineGap",           ${typo_line_gap})
  SetOS2Value("HHeadAscent",           ${firge35_ascent})
  SetOS2Value("HHeadDescent",         -${firge35_descent})
  SetOS2Value("HHeadLineGap",            0)
  SetPanose([2, 11, panoseweight_list[i], 9, 2, 2, 3, 2, 2, 7])

  # Merge Hack font
  Print("Merge " + hack_list[i]:t)
  MergeFonts(hack_list[i])

  # Save Firge
  if (fontfamilysuffix != "")
        Print("Save " + fontfamily + fontfamilysuffix + "-" + fontstyle_list[i] + ".ttf")
        Generate("${base_dir}/" + fontfamily + fontfamilysuffix + "-" + fontstyle_list[i] + ".ttf", "")
  else
        Print("Save " + fontfamily + "-" + fontstyle_list[i] + ".ttf")
        Generate("${base_dir}/" + fontfamily + "-" + fontstyle_list[i] + ".ttf", "")
  endif
  Close()

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate extraction box drawing light for Firge
########################################

cat > ${tmpdir}/${firge_box_drawing_light_generator} << _EOT_
#!$fontforge_command -script

# Print message
Print("Generate extraction box drawing light for Firge")

# Set parameters
hack_list  = ["${tmpdir}/${modified_hack_box_drawing_light_regular}", \\
                     "${tmpdir}/${modified_hack_box_drawing_light_bold}"]
fontfamily        = "${firge_box_drawing_light_familyname}"
fontfamilysuffix  = "${firge_familyname_suffix}"
fontstyle_list    = ["Regular", "Bold"]
fontweight_list   = [400,       700]
panoseweight_list = [5,         8]
copyright         = "${copyright}"
version           = "${firge_version}"

# Begin loop of regular and bold
i = 0
while (i < SizeOf(fontstyle_list))
  # Open new file
  New()

  # Set encoding to Unicode-bmp
  Reencode("unicode")

  # Set configuration
  if (fontfamilysuffix != "")
        SetFontNames(fontfamily + fontfamilysuffix + "-" + fontstyle_list[i], \\
                     fontfamily + " " + fontfamilysuffix, \\
                     fontfamily + " " + fontfamilysuffix + " " + fontstyle_list[i], \\
                     fontstyle_list[i], \\
                     copyright, version)
  else
        SetFontNames(fontfamily + "-" + fontstyle_list[i], \\
                     fontfamily, \\
                     fontfamily + " " + fontstyle_list[i], \\
                     fontstyle_list[i], \\
                     copyright, version)
  endif
  SetTTFName(0x409, 2, fontstyle_list[i])
  SetTTFName(0x409, 3, "FontForge 2.0 : " + \$fullname + " : " + Strftime("%d-%m-%Y", 0))
  ScaleToEm(${em_ascent}, ${em_descent})
  SetOS2Value("Weight", fontweight_list[i]) # Book or Bold
  SetOS2Value("Width",                   5) # Medium
  SetOS2Value("FSType",                  0)
  SetOS2Value("VendorID",           "PfEd")
  SetOS2Value("IBMFamily",            2057) # SS Typewriter Gothic
  SetOS2Value("WinAscentIsOffset",       0)
  SetOS2Value("WinDescentIsOffset",      0)
  SetOS2Value("TypoAscentIsOffset",      0)
  SetOS2Value("TypoDescentIsOffset",     0)
  SetOS2Value("HHeadAscentIsOffset",     0)
  SetOS2Value("HHeadDescentIsOffset",    0)
  SetOS2Value("WinAscent",             ${firge_ascent})
  SetOS2Value("WinDescent",            ${firge_descent})
  SetOS2Value("TypoAscent",            ${em_ascent})
  SetOS2Value("TypoDescent",          -${em_descent})
  SetOS2Value("TypoLineGap",           ${typo_line_gap})
  SetOS2Value("HHeadAscent",           ${firge_ascent})
  SetOS2Value("HHeadDescent",         -${firge_descent})
  SetOS2Value("HHeadLineGap",            0)
  SetPanose([2, 11, panoseweight_list[i], 9, 2, 2, 3, 2, 2, 7])

  # Merge Hack font
  Print("Merge " + hack_list[i]:t)
  MergeFonts(hack_list[i])

  # Save Firge
  if (fontfamilysuffix != "")
        Print("Save " + fontfamily + fontfamilysuffix + "-" + fontstyle_list[i] + ".ttf")
        Generate("${base_dir}/" + fontfamily + fontfamilysuffix + "-" + fontstyle_list[i] + ".ttf", "")
  else
        Print("Save " + fontfamily + "-" + fontstyle_list[i] + ".ttf")
        Generate("${base_dir}/" + fontfamily + "-" + fontstyle_list[i] + ".ttf", "")
  endif
  Close()

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate extraction box drawing light for Firge35
########################################

cat > ${tmpdir}/${firge35_box_drawing_light_generator} << _EOT_
#!$fontforge_command -script

# Print message
Print("Generate extraction box drawing light for Firge35")

# Set parameters
hack_list  = ["${tmpdir}/${modified_hack35_box_drawing_light_regular}", \\
                     "${tmpdir}/${modified_hack35_box_drawing_light_bold}"]
fontfamily        = "${firge35_box_drawing_light_familyname}"
fontfamilysuffix  = "${firge_familyname_suffix}"
fontstyle_list    = ["Regular", "Bold"]
fontweight_list   = [400,       700]
panoseweight_list = [5,         8]
copyright         = "${copyright}"
version           = "${firge_version}"

# Begin loop of regular and bold
i = 0
while (i < SizeOf(fontstyle_list))
  # Open new file
  New()

  # Set encoding to Unicode-bmp
  Reencode("unicode")

  # Set configuration
  if (fontfamilysuffix != "")
        SetFontNames(fontfamily + fontfamilysuffix + "-" + fontstyle_list[i], \\
                     fontfamily + " " + fontfamilysuffix, \\
                     fontfamily + " " + fontfamilysuffix + " " + fontstyle_list[i], \\
                     fontstyle_list[i], \\
                     copyright, version)
  else
        SetFontNames(fontfamily + "-" + fontstyle_list[i], \\
                     fontfamily, \\
                     fontfamily + " " + fontstyle_list[i], \\
                     fontstyle_list[i], \\
                     copyright, version)
  endif
  SetTTFName(0x409, 2, fontstyle_list[i])
  SetTTFName(0x409, 3, "FontForge 2.0 : " + \$fullname + " : " + Strftime("%d-%m-%Y", 0))
  ScaleToEm(${em_ascent}, ${em_descent})
  SetOS2Value("Weight", fontweight_list[i]) # Book or Bold
  SetOS2Value("Width",                   5) # Medium
  SetOS2Value("FSType",                  0)
  SetOS2Value("VendorID",           "PfEd")
  SetOS2Value("IBMFamily",            2057) # SS Typewriter Gothic
  SetOS2Value("WinAscentIsOffset",       0)
  SetOS2Value("WinDescentIsOffset",      0)
  SetOS2Value("TypoAscentIsOffset",      0)
  SetOS2Value("TypoDescentIsOffset",     0)
  SetOS2Value("HHeadAscentIsOffset",     0)
  SetOS2Value("HHeadDescentIsOffset",    0)
  SetOS2Value("WinAscent",             ${firge35_ascent})
  SetOS2Value("WinDescent",            ${firge35_descent})
  SetOS2Value("TypoAscent",            ${em_ascent})
  SetOS2Value("TypoDescent",          -${em_descent})
  SetOS2Value("TypoLineGap",           ${typo_line_gap})
  SetOS2Value("HHeadAscent",           ${firge35_ascent})
  SetOS2Value("HHeadDescent",         -${firge35_descent})
  SetOS2Value("HHeadLineGap",            0)
  SetPanose([2, 11, panoseweight_list[i], 9, 2, 2, 3, 2, 2, 7])

  # Merge Hack font
  Print("Merge " + hack_list[i]:t)
  MergeFonts(hack_list[i])

  # Save Firge
  if (fontfamilysuffix != "")
        Print("Save " + fontfamily + fontfamilysuffix + "-" + fontstyle_list[i] + ".ttf")
        Generate("${base_dir}/" + fontfamily + fontfamilysuffix + "-" + fontstyle_list[i] + ".ttf", "")
  else
        Print("Save " + fontfamily + "-" + fontstyle_list[i] + ".ttf")
        Generate("${base_dir}/" + fontfamily + "-" + fontstyle_list[i] + ".ttf", "")
  endif
  Close()

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate script for Firge Console
########################################

cat > ${tmpdir}/${firge_console_generator} << _EOT_
#!$fontforge_command -script

# Print message
Print("Generate Firge Console")

# Set parameters
hack_list  = ["${tmpdir}/${modified_hack_console_regular}", \\
                     "${tmpdir}/${modified_hack_console_bold}"]
fontfamily        = "${firge_familyname}"
fontfamilysuffix  = "${firge_console_suffix}"
fontstyle_list    = ["Regular", "Bold"]
fontweight_list   = [400,       700]
panoseweight_list = [5,         8]
copyright         = "${copyright}"
version           = "${firge_version}"

# Begin loop of regular and bold
i = 0
while (i < SizeOf(fontstyle_list))
  # Open new file
  New()

  # Set encoding to Unicode-bmp
  Reencode("unicode")

  # Set configuration
  if (fontfamilysuffix != "")
        SetFontNames(fontfamily + fontfamilysuffix + "-" + fontstyle_list[i], \\
                     fontfamily + " " + fontfamilysuffix, \\
                     fontfamily + " " + fontfamilysuffix + " " + fontstyle_list[i], \\
                     fontstyle_list[i], \\
                     copyright, version)
  else
        SetFontNames(fontfamily + "-" + fontstyle_list[i], \\
                     fontfamily, \\
                     fontfamily + " " + fontstyle_list[i], \\
                     fontstyle_list[i], \\
                     copyright, version)
  endif
  SetTTFName(0x409, 2, fontstyle_list[i])
  SetTTFName(0x409, 3, "FontForge 2.0 : " + \$fullname + " : " + Strftime("%d-%m-%Y", 0))
  ScaleToEm(${em_ascent}, ${em_descent})
  SetOS2Value("Weight", fontweight_list[i]) # Book or Bold
  SetOS2Value("Width",                   5) # Medium
  SetOS2Value("FSType",                  0)
  SetOS2Value("VendorID",           "PfEd")
  SetOS2Value("IBMFamily",            2057) # SS Typewriter Gothic
  SetOS2Value("WinAscentIsOffset",       0)
  SetOS2Value("WinDescentIsOffset",      0)
  SetOS2Value("TypoAscentIsOffset",      0)
  SetOS2Value("TypoDescentIsOffset",     0)
  SetOS2Value("HHeadAscentIsOffset",     0)
  SetOS2Value("HHeadDescentIsOffset",    0)
  SetOS2Value("WinAscent",             ${firge_ascent})
  SetOS2Value("WinDescent",            ${firge_descent})
  SetOS2Value("TypoAscent",            ${em_ascent})
  SetOS2Value("TypoDescent",          -${em_descent})
  SetOS2Value("TypoLineGap",           ${typo_line_gap})
  SetOS2Value("HHeadAscent",           ${firge_ascent})
  SetOS2Value("HHeadDescent",         -${firge_descent})
  SetOS2Value("HHeadLineGap",            0)
  SetPanose([2, 11, panoseweight_list[i], 9, 2, 2, 3, 2, 2, 7])

  # Merge Hack font
  Print("Merge " + hack_list[i]:t)
  MergeFonts(hack_list[i])

  # Save Firge
  if (fontfamilysuffix != "")
        Print("Save " + fontfamily + fontfamilysuffix + "-" + fontstyle_list[i] + ".ttf")
        Generate("${base_dir}/" + fontfamily + fontfamilysuffix + "-" + fontstyle_list[i] + ".ttf", "")
  else
        Print("Save " + fontfamily + "-" + fontstyle_list[i] + ".ttf")
        Generate("${base_dir}/" + fontfamily + "-" + fontstyle_list[i] + ".ttf", "")
  endif
  Close()

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate script for Firge35
########################################

cat > ${tmpdir}/${firge35_generator} << _EOT_
#!$fontforge_command -script

# Print message
Print("Generate Firge")

# Set parameters
hack_list  = ["${tmpdir}/${modified_hack35_regular}", \\
                     "${tmpdir}/${modified_hack35_bold}"]
fontfamily        = "${firge35_familyname}"
fontfamilysuffix  = "${firge35_familyname_suffix}"
fontstyle_list    = ["Regular", "Bold"]
fontweight_list   = [400,       700]
panoseweight_list = [5,         8]
copyright         = "${copyright}"
version           = "${firge_version}"

# Begin loop of regular and bold
i = 0
while (i < SizeOf(fontstyle_list))
  # Open new file
  New()

  # Set encoding to Unicode-bmp
  Reencode("unicode")

  # Set configuration
  if (fontfamilysuffix != "")
        SetFontNames(fontfamily + fontfamilysuffix + "-" + fontstyle_list[i], \\
                     fontfamily + " " + fontfamilysuffix, \\
                     fontfamily + " " + fontfamilysuffix + " " + fontstyle_list[i], \\
                     fontstyle_list[i], \\
                     copyright, version)
  else
        SetFontNames(fontfamily + "-" + fontstyle_list[i], \\
                     fontfamily, \\
                     fontfamily + " " + fontstyle_list[i], \\
                     fontstyle_list[i], \\
                     copyright, version)
  endif
  SetTTFName(0x409, 2, fontstyle_list[i])
  SetTTFName(0x409, 3, "FontForge 2.0 : " + \$fullname + " : " + Strftime("%d-%m-%Y", 0))
  ScaleToEm(${em_ascent}, ${em_descent})
  SetOS2Value("Weight", fontweight_list[i]) # Book or Bold
  SetOS2Value("Width",                   5) # Medium
  SetOS2Value("FSType",                  0)
  SetOS2Value("VendorID",           "PfEd")
  SetOS2Value("IBMFamily",            2057) # SS Typewriter Gothic
  SetOS2Value("WinAscentIsOffset",       0)
  SetOS2Value("WinDescentIsOffset",      0)
  SetOS2Value("TypoAscentIsOffset",      0)
  SetOS2Value("TypoDescentIsOffset",     0)
  SetOS2Value("HHeadAscentIsOffset",     0)
  SetOS2Value("HHeadDescentIsOffset",    0)
  SetOS2Value("WinAscent",             ${firge35_ascent})
  SetOS2Value("WinDescent",            ${firge35_descent})
  SetOS2Value("TypoAscent",            ${em_ascent})
  SetOS2Value("TypoDescent",          -${em_descent})
  SetOS2Value("TypoLineGap",           ${typo_line_gap})
  SetOS2Value("HHeadAscent",           ${firge35_ascent})
  SetOS2Value("HHeadDescent",         -${firge35_descent})
  SetOS2Value("HHeadLineGap",            0)
  SetPanose([2, 11, panoseweight_list[i], 9, 2, 2, 3, 2, 2, 7])

  # Merge Hack font
  Print("Merge " + hack_list[i]:t)
  MergeFonts(hack_list[i])

  # Save Firge
  if (fontfamilysuffix != "")
        Print("Save " + fontfamily + fontfamilysuffix + "-" + fontstyle_list[i] + ".ttf")
        Generate("${base_dir}/" + fontfamily + fontfamilysuffix + "-" + fontstyle_list[i] + ".ttf", "")
  else
        Print("Save " + fontfamily + "-" + fontstyle_list[i] + ".ttf")
        Generate("${base_dir}/" + fontfamily + "-" + fontstyle_list[i] + ".ttf", "")
  endif
  Close()

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate script for Firge35 Console
########################################

cat > ${tmpdir}/${firge35_console_generator} << _EOT_
#!$fontforge_command -script

# Print message
Print("Generate Firge Console")

# Set parameters
hack_list  = ["${tmpdir}/${modified_hack35_console_regular}", \\
                     "${tmpdir}/${modified_hack35_console_bold}"]
fontfamily        = "${firge35_familyname}"
fontfamilysuffix  = "${firge_console_suffix}"
fontstyle_list    = ["Regular", "Bold"]
fontweight_list   = [400,       700]
panoseweight_list = [5,         8]
copyright         = "${copyright}"
version           = "${firge_version}"

# Begin loop of regular and bold
i = 0
while (i < SizeOf(fontstyle_list))
  # Open new file
  New()

  # Set encoding to Unicode-bmp
  Reencode("unicode")

  # Set configuration
  if (fontfamilysuffix != "")
        SetFontNames(fontfamily + fontfamilysuffix + "-" + fontstyle_list[i], \\
                     fontfamily + " " + fontfamilysuffix, \\
                     fontfamily + " " + fontfamilysuffix + " " + fontstyle_list[i], \\
                     fontstyle_list[i], \\
                     copyright, version)
  else
        SetFontNames(fontfamily + "-" + fontstyle_list[i], \\
                     fontfamily, \\
                     fontfamily + " " + fontstyle_list[i], \\
                     fontstyle_list[i], \\
                     copyright, version)
  endif
  SetTTFName(0x409, 2, fontstyle_list[i])
  SetTTFName(0x409, 3, "FontForge 2.0 : " + \$fullname + " : " + Strftime("%d-%m-%Y", 0))
  ScaleToEm(${em_ascent}, ${em_descent})
  SetOS2Value("Weight", fontweight_list[i]) # Book or Bold
  SetOS2Value("Width",                   5) # Medium
  SetOS2Value("FSType",                  0)
  SetOS2Value("VendorID",           "PfEd")
  SetOS2Value("IBMFamily",            2057) # SS Typewriter Gothic
  SetOS2Value("WinAscentIsOffset",       0)
  SetOS2Value("WinDescentIsOffset",      0)
  SetOS2Value("TypoAscentIsOffset",      0)
  SetOS2Value("TypoDescentIsOffset",     0)
  SetOS2Value("HHeadAscentIsOffset",     0)
  SetOS2Value("HHeadDescentIsOffset",    0)
  SetOS2Value("WinAscent",             ${firge35_ascent})
  SetOS2Value("WinDescent",            ${firge35_descent})
  SetOS2Value("TypoAscent",            ${em_ascent})
  SetOS2Value("TypoDescent",          -${em_descent})
  SetOS2Value("TypoLineGap",           ${typo_line_gap})
  SetOS2Value("HHeadAscent",           ${firge35_ascent})
  SetOS2Value("HHeadDescent",         -${firge35_descent})
  SetOS2Value("HHeadLineGap",            0)
  SetPanose([2, 11, panoseweight_list[i], 9, 2, 2, 3, 2, 2, 7])

  # Merge Hack font
  Print("Merge " + hack_list[i]:t)
  MergeFonts(hack_list[i])

  # Save Firge
  if (fontfamilysuffix != "")
        Print("Save " + fontfamily + fontfamilysuffix + "-" + fontstyle_list[i] + ".ttf")
        Generate("${base_dir}/" + fontfamily + fontfamilysuffix + "-" + fontstyle_list[i] + ".ttf", "")
  else
        Print("Save " + fontfamily + "-" + fontstyle_list[i] + ".ttf")
        Generate("${base_dir}/" + fontfamily + "-" + fontstyle_list[i] + ".ttf", "")
  endif
  Close()

  i += 1
endloop

Quit()
_EOT_

########################################
# Generate Firge
########################################

# Generate Material
$fontforge_command -script ${tmpdir}/${modified_hack_material_generator} 2> $redirection_stderr || exit 4

# Generate Console
$fontforge_command -script ${tmpdir}/${modified_hack_console_generator} 2> $redirection_stderr || exit 4

# Generate Modiifed Hack
$fontforge_command -script ${tmpdir}/${modified_hack_generator} 2> $redirection_stderr || exit 4

# Generate Modified GenJyuu
$fontforge_command -script ${tmpdir}/${modified_genjyuu_generator} 2> $redirection_stderr || exit 4

# Generate powerline Symbol
$fontforge_command -script ${tmpdir}/${modified_hack_powerline_generator} 2> $redirection_stderr || exit 4

# Generate powerline Symbol
$fontforge_command -script ${tmpdir}/${modified_hack35_powerline_generator} 2> $redirection_stderr || exit 4

# Generate Modified Firge Nerd Symbol
$fontforge_command -script ${tmpdir}/${modified_firge_nerd_symbol_generator} 2> $redirection_stderr || exit 4

# Generate Modified Firge Nerd Symbol
$fontforge_command -script ${tmpdir}/${modified_firge35_nerd_symbol_generator} 2> $redirection_stderr || exit 4

# Generate Modified Firge Console Nerd Symbol
$fontforge_command -script ${tmpdir}/${modified_firge_nerd_console_symbol_generator} 2> $redirection_stderr || exit 4

# Generate Modified Firge Console Nerd Symbol
$fontforge_command -script ${tmpdir}/${modified_firge35_nerd_console_symbol_generator} 2> $redirection_stderr || exit 4

# Generate Hack evacuation symbol
# $fontforge_command -script ${tmpdir}/${modified_hack_evacuate_from_hinting_generator} 2> $redirection_stderr || exit 4

# Generate Hack 35 evacuation symbol
# $fontforge_command -script ${tmpdir}/${modified_hack35_evacuate_from_hinting_generator} 2> $redirection_stderr || exit 4

# Generate Hack box drawing light symbols
$fontforge_command -script ${tmpdir}/${modified_hack_box_drawing_light_generator} 2> $redirection_stderr || exit 4

# Generate Hack 35 box drawing light evacuation symbols
$fontforge_command -script ${tmpdir}/${modified_hack35_box_drawing_light_generator} 2> $redirection_stderr || exit 4

# Generate Modified GenJyuu Console
$fontforge_command -script ${tmpdir}/${modified_genjyuu_console_generator} 2> $redirection_stderr || exit 4

# Generate Firge
$fontforge_command -script ${tmpdir}/${firge_generator} 2> $redirection_stderr || exit 4

# Generate Firge Console
$fontforge_command -script ${tmpdir}/${firge_console_generator} 2> $redirection_stderr || exit 4

# Generate Console - 35
$fontforge_command -script ${tmpdir}/${modified_hack35_console_generator} 2> $redirection_stderr || exit 4

# Generate Modiifed Hack - 35
$fontforge_command -script ${tmpdir}/${modified_hack35_generator} 2> $redirection_stderr || exit 4

# Generate Modified GenJyuu - 35
$fontforge_command -script ${tmpdir}/${modified_genjyuu35_generator} 2> $redirection_stderr || exit 4

# Generate Modified GenJyuu Console - 35
$fontforge_command -script ${tmpdir}/${modified_genjyuu35_console_generator} 2> $redirection_stderr || exit 4

# Generate Firge - 35
$fontforge_command -script ${tmpdir}/${firge35_generator} 2> $redirection_stderr || exit 4

# Generate Firge Console - 35
$fontforge_command -script ${tmpdir}/${firge35_console_generator} 2> $redirection_stderr || exit 4

# Generate Firge Nerd Symbol
$fontforge_command -script ${tmpdir}/${firge_nerd_symbol_generator} 2> $redirection_stderr || exit 4

# Generate Firge35 Nerd Symbol
$fontforge_command -script ${tmpdir}/${firge35_nerd_symbol_generator} 2> $redirection_stderr || exit 4

# Generate Firge Nerd Symbol
$fontforge_command -script ${tmpdir}/${firge_nerd_console_symbol_generator} 2> $redirection_stderr || exit 4

# Generate Firge35 Nerd Symbol
$fontforge_command -script ${tmpdir}/${firge35_nerd_console_symbol_generator} 2> $redirection_stderr || exit 4

# Generate Firge evacuation symbol from hinting
# $fontforge_command -script ${tmpdir}/${firge_evacuate_from_hinting_generator} 2> $redirection_stderr || exit 4

# Generate Firge35 evacuation symbol from hinting
# $fontforge_command -script ${tmpdir}/${firge35_evacuate_from_hinting_generator} 2> $redirection_stderr || exit 4

# Generate Firge box drawing light symbols from hinting
$fontforge_command -script ${tmpdir}/${firge_box_drawing_light_generator} 2> $redirection_stderr || exit 4

# Generate Firge35 box drawing light symbols from hinting
$fontforge_command -script ${tmpdir}/${firge35_box_drawing_light_generator} 2> $redirection_stderr || exit 4

# Add hinting Firge Regular
for f in ${firge_familyname}-Regular.ttf ${firge_familyname}${firge_console_suffix}-Regular.ttf
do
  ttfautohint -l 6 -r 45 -a qsq -D latn -W -I "$f" "hinted_${f}"
done
# Add hinting Firge Bold
for f in ${firge_familyname}-Bold.ttf ${firge_familyname}${firge_console_suffix}-Bold.ttf
do
  ttfautohint -l 6 -r 45 -a qsq -D latn -W -I "$f" "hinted_${f}"
done
# Add hinting Firge35 Regular
for f in ${firge35_familyname}-Regular.ttf ${firge35_familyname}${firge_console_suffix}-Regular.ttf
do
  ttfautohint -l 6 -r 45 -a qsq -D latn -W -I "$f" "hinted_${f}"
done
# Add hinting Firge35 Bold
for f in ${firge35_familyname}-Bold.ttf ${firge35_familyname}${firge_console_suffix}-Bold.ttf
do
  ttfautohint -l 6 -r 45 -a qsq -D latn -W -I "$f" "hinted_${f}"
done

for style in Regular Bold
do
  if [ "${style}" = 'Regular' ]; then
    marge_genjyuu_regular="${tmpdir}/${modified_genjyuu_regular}.ttf"
    marge_genjyuu_console_regular="${tmpdir}/${modified_genjyuu_console_regular}.ttf"
    marge_genjyuu35_regular="${tmpdir}/${modified_genjyuu35_regular}.ttf"
    marge_genjyuu35_console_regular="${tmpdir}/${modified_genjyuu35_console_regular}.ttf"
  fi
  if [ "${style}" = 'Bold' ]; then
    marge_genjyuu_regular="${tmpdir}/${modified_genjyuu_bold}.ttf"
    marge_genjyuu_console_regular="${tmpdir}/${modified_genjyuu_console_bold}.ttf"
    marge_genjyuu35_regular="${tmpdir}/${modified_genjyuu35_bold}.ttf"
    marge_genjyuu35_console_regular="${tmpdir}/${modified_genjyuu35_console_bold}.ttf"
  fi

  firge_filename="${firge_familyname}-${style}.ttf"
  firge_console_filename="${firge_familyname}${firge_console_suffix}-${style}.ttf"
  firge35_filename="${firge35_familyname}-${style}.ttf"
  firge35_console_filename="${firge35_familyname}${firge_console_suffix}-${style}.ttf"

  firge_nerd_filename="${firge_nerd_familyname}-${style}.ttf"
  firge_nerd_console_filename="${firge_nerd_familyname}${firge_console_suffix}-${style}.ttf"
  firge35_nerd_filename="${firge35_nerd_familyname}-${style}.ttf"
  firge35_nerd_console_filename="${firge35_nerd_familyname}${firge_console_suffix}-${style}.ttf"

  # Firge
  echo "pyftmerge: ${firge_filename}"
  # pyftmerge "hinted_${firge_filename}" "${firge_evacuation_symbol_familyname}${firge_familyname_suffix}-${style}.ttf"
  # pyftmerge merged.ttf "$marge_genjyuu_regular"
  pyftmerge "hinted_${firge_filename}" "$marge_genjyuu_regular"
  mv merged.ttf "${firge_filename}"

  # Firge Console
  echo "pyftmerge: ${firge_console_filename}"
  # pyftmerge "hinted_${firge_console_filename}" "${firge_evacuation_symbol_familyname}${firge_familyname_suffix}-${style}.ttf"
  # pyftmerge merged.ttf "${firge_box_drawing_light_familyname}${firge_familyname_suffix}-${style}.ttf"
  # pyftmerge merged.ttf "$marge_genjyuu_console_regular"
  pyftmerge "hinted_${firge_console_filename}" "${firge_box_drawing_light_familyname}${firge_familyname_suffix}-${style}.ttf"
  pyftmerge merged.ttf "$marge_genjyuu_console_regular"
  mv merged.ttf "${firge_console_filename}"

  # Firge35
  echo "pyftmerge: ${firge35_filename}"
  # pyftmerge "hinted_${firge35_filename}" "${firge35_evacuation_symbol_familyname}${firge35_familyname_suffix}-${style}.ttf"
  # pyftmerge merged.ttf "$marge_genjyuu35_regular"
  pyftmerge "hinted_${firge35_filename}" "$marge_genjyuu35_regular"
  mv merged.ttf "${firge35_filename}"

  # Firge35 Console
  echo "pyftmerge: ${firge35_console_filename}"
  # pyftmerge "hinted_${firge35_console_filename}" "${firge35_evacuation_symbol_familyname}${firge35_familyname_suffix}-${style}.ttf"
  # pyftmerge merged.ttf "${firge35_box_drawing_light_familyname}${firge35_familyname_suffix}-${style}.ttf"
  # pyftmerge merged.ttf "$marge_genjyuu35_console_regular"
  pyftmerge "hinted_${firge35_console_filename}" "${firge35_box_drawing_light_familyname}${firge35_familyname_suffix}-${style}.ttf"
  pyftmerge merged.ttf "$marge_genjyuu35_console_regular"
  mv merged.ttf "${firge35_console_filename}"

  # Firge Nerd
  # echo "pyftmerge: ${firge_nerd_filename}"
  # # pyftmerge "${firge_filename}" "${firge_evacuation_nerd_familyname}${firge_familyname_suffix}-${style}.ttf"
  # # mv merged.ttf "${firge_nerd_filename}"
  # pyftmerge "hinted_${firge_filename}" "${firge_evacuation_nerd_familyname}${firge_familyname_suffix}-${style}.ttf"
  # pyftmerge merged.ttf "$marge_genjyuu_regular"
  # mv merged.ttf "${firge_nerd_filename}"
  # ttx -t name "${firge_nerd_filename}"
  # sed -i -e 's/Firge/FirgeNerd/g' "${firge_nerd_filename%%.ttf}.ttx"
  # mv "${firge_nerd_filename}" "${firge_nerd_filename}_orig"
  # ttx -m "${firge_nerd_filename}_orig" "${firge_nerd_filename%%.ttf}.ttx"

  # Firge Nerd Console
  echo "pyftmerge: ${firge_nerd_console_filename}"
  # pyftmerge "${firge_console_filename}" "${firge_evacuation_nerd_familyname}${firge_console_suffix}-${style}.ttf"
  # mv merged.ttf "${firge_nerd_console_filename}"
  pyftmerge "hinted_${firge_console_filename}" "${firge_box_drawing_light_familyname}${firge_familyname_suffix}-${style}.ttf"
  pyftmerge merged.ttf "${firge_evacuation_nerd_familyname}${firge_console_suffix}-${style}.ttf"
  pyftmerge merged.ttf "$marge_genjyuu_console_regular"
  mv merged.ttf "${firge_nerd_console_filename}"
  ttx -t name "${firge_nerd_console_filename}"
  sed -i -e 's/Firge/FirgeNerd/g' "${firge_nerd_console_filename%%.ttf}.ttx"
  mv "${firge_nerd_console_filename}" "${firge_nerd_console_filename}_orig"
  ttx -m "${firge_nerd_console_filename}_orig" "${firge_nerd_console_filename%%.ttf}.ttx"

  # Firge35 Nerd
  # echo "pyftmerge: ${firge35_nerd_filename}"
  # # pyftmerge "${firge35_filename}" "${firge35_evacuation_nerd_familyname}${firge35_familyname_suffix}-${style}.ttf"
  # # mv merged.ttf "${firge35_nerd_filename}"
  # pyftmerge "hinted_${firge35_filename}" "${firge35_evacuation_nerd_familyname}${firge35_familyname_suffix}-${style}.ttf"
  # pyftmerge merged.ttf "$marge_genjyuu35_regular"
  # mv merged.ttf "${firge35_nerd_filename}"
  # ttx -t name "${firge35_nerd_filename}"
  # sed -i -e 's/Firge35/Firge35Nerd/g' "${firge35_nerd_filename%%.ttf}.ttx"
  # mv "${firge35_nerd_filename}" "${firge35_nerd_filename}_orig"
  # ttx -m "${firge35_nerd_filename}_orig" "${firge35_nerd_filename%%.ttf}.ttx"

  # Firge35 Nerd Console
  echo "pyftmerge: ${firge35_nerd_console_filename}"
  # pyftmerge "${firge35_console_filename}" "${firge35_evacuation_nerd_familyname}${firge_console_suffix}-${style}.ttf"
  # mv merged.ttf "${firge35_nerd_console_filename}"
  pyftmerge "hinted_${firge35_console_filename}" "${firge35_box_drawing_light_familyname}${firge35_familyname_suffix}-${style}.ttf"
  pyftmerge merged.ttf "${firge35_evacuation_nerd_familyname}${firge_console_suffix}-${style}.ttf"
  pyftmerge merged.ttf "$marge_genjyuu35_console_regular"
  mv merged.ttf "${firge35_nerd_console_filename}"
  ttx -t name "${firge35_nerd_console_filename}"
  sed -i -e 's/Firge35/Firge35Nerd/g' "${firge35_nerd_console_filename%%.ttf}.ttx"
  mv "${firge35_nerd_console_filename}" "${firge35_nerd_console_filename}_orig"
  ttx -m "${firge35_nerd_console_filename}_orig" "${firge35_nerd_console_filename%%.ttf}.ttx"

done

rm -f hinted_*.ttf
rm -f "${firge_evacuation_symbol_familyname}"*.ttf
rm -f "${firge35_evacuation_symbol_familyname}"*.ttf
rm -f "${firge_evacuation_nerd_familyname}"*.ttf
rm -f "${firge35_evacuation_nerd_familyname}"*.ttf
rm -f "${firge_nerd_familyname}"*.ttx
rm -f "${firge35_nerd_familyname}"*.ttx
rm -f "${firge_box_drawing_light_familyname}"*.ttf
rm -f "${firge35_box_drawing_light_familyname}"*.ttf

# Remove temporary directory
if [ "${leaving_tmp_flag}" = "false" ]
then
  echo "Remove temporary files"
  rm -rf $tmpdir
fi

# Exit
echo "Succeeded in generating Firge!"
exit 0
