#! /bin/sh
# Based on @zporter's publish script.
# See https://zachporter.dev/posts/publishing-hugo-with-github-actions/

# abort on nonzero exitstatus
set -o errexit
# abort on unbound variable
set -o nounset

# Output directory
output_dir=gh-pages

# Time stamp to indicate latest publishing date
timestamp=$(date --utc --iso-8601=seconds)

# Exit if there are local changes
if [ "$(git status -s)" ]; then
  printf 'Changes detected in working directory. Commit them before proceeding.\n'
  exit 1
fi

printf 'Deleting old publication\n'
rm -rf "${output_dir}"
mkdir "${output_dir}"
git worktree prune
rm -rf ".git/worktrees/${output_dir}"

printf 'Fetch gh-pages branch\n'
git fetch origin gh-pages

printf 'Checking out gh-pages branch\n'
git worktree add -B gh-pages ${output_dir} origin/gh-pages

printf 'Running make to generate new version\n'
make clean
make all    # Generate slides
cp index.md "${output_dir}/README.md"

sed -i "s/^Published: /Published: ${timestamp}/" \
  "${output_dir}/README.md"

printf 'Updating gh-pages branch\n'
cd "${output_dir}" \
  && git add --all \
  && git commit -m "Publishing to gh-pages (${0}) at ${timestamp}"

printf 'Pushing to Github\n'
git push "${REPOSITORY:-origin}" gh-pages
