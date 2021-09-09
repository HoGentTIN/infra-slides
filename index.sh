#! /usr/bin/env bash
#
# Author: Bert Van Vreckem <bert.vanvreckem@gmail.com>
#
#/ Usage: ./index.sh
#/
#/ Generate README.md index file with links to all reveal.js presentations
#/  


#{{{ Bash settings
# abort on nonzero exitstatus
set -o errexit
# abort on unbound variable
set -o nounset
# don't hide errors within pipes
set -o pipefail
#}}}
#{{{ Variables
readonly script_name=$(basename "${0}")
readonly script_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
IFS=$'\t\n'   # Split on newlines and tabs (but not on spaces)

output_dir=gh-pages
index_file="README.md"
#}}}

cd "${output_dir}"

cat > "${index_file}" << _EOF_
# Slides Infrastructure Automation

Hier vind je de slides voor de lessen van de cursus Infrastructure Automation in de professionele bacheloropleiding toegepaste informatica aan HOGENT.

_EOF_

index=1
for presentation in *.html; do
  # Extract the <title> and remove HTML tags and whitespace
  title=$(grep -F '<title>' "${presentation}" | sed -E 's/<[^>]*>//g;s/^\s+//')

  # Print an ordered list with presentation title and link to the .html file
  printf '%d. [%s](%s)\n' "${index}" "${title}" "${presentation}" >> "${index_file}"

  # Increment list index
  index=$((index + 1))
done