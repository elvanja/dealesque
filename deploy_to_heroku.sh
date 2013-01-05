#!/bin/sh

git checkout -b deploy_to_heroku
RAILS_ENV=production rake assets:precompile
git add -A .
git commit -m "added precompiled assets"
