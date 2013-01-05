#!/bin/sh

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
git branch -D feature/deploy_to_heroku