#!/bin/sh

# http://stackoverflow.com/questions/3878624/how-do-i-programmatically-determine-if-there-are-uncommited-changes
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
      echo >&2 "please commit or stash them."
      exit 1
  fi
}

CALLER_BRANCH="$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)"

echo "checking working tree status, must be clear"
require_clean_work_tree
echo "creating deploy branch"
git checkout -b deploy_to_heroku
echo "compiling assets"
RAILS_ENV=production rake assets:precompile
echo "commiting compiled assets"
git add -A .
git commit -m "added precompiled assets"
echo "pushing to heroku"
#git push -f heroku HEAD:master
echo "returning to trigger branch"
git checkout $CALLER_BRANCH
echo "removing deploy branch"
git branch -D deploy_to_heroku