#!/bin/sh

cd themes/minimo
sass src/stylesheets/style.scss static/assets/css/main.ab98e12b.css
cd ../..

# if a command fails then deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# build project
hugo

# go to public folder
cd public

# add changes to git
git add .

# commit changes
msg="rebuilding site $(date)"
if [ -n "$*" ]; then 
	msg="$*"
fi
git commit -m "$msg"

# push source and build repos
git push origin master


