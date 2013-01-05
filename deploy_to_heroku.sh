#!/bin/sh

require_clean_work_tree () {
  # Update the index
  git update-index -q --ignore-submodules --refresh
  err=0

  # Disallow unstaged changes in the working tree
  if ! git diff-files --quiet --ignore-submodules --; then
      echo >&2 "cannot deploy to heroku: you have unstaged changes."
      git diff-files --name-status -r --ignore-submodules -- >&2
      err=1
  fi

  # Disallow uncommitted changes in the index
  if ! git diff-index --cached --quiet HEAD --ignore-submodules --; then
      echo >&2 "cannot deploy to heroku: your index contains uncommitted changes."
      git diff-index --cached --name-status -r --ignore-submodules HEAD -- >&2
      err=1
  fi

  if [ $err = 1 ]; then
      echo >&2 "Please commit or stash them."
      exit 1
  fi
}


require_clean_work_tree
echo "all ok"
exit

git flow release start deploy_to_heroku
if [ $? -ne 0 ]; then
  echo "You must have a clean branch to deploy to heroku"
  exit
fi
RAILS_ENV=production rake assets:precompile
git add -A .
git commit -m "added precompiled assets"
#git push -f heroku HEAD:master
git checkout develop
git branch -D release/deploy_to_heroku