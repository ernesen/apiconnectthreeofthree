#!/bin/bash

# https://gist.github.com/robwierzbowski/5430952/
# Create and push to a new github repo from the command line.
# Grabs sensible defaults from the containing folder and `.gitconfig`.
# Refinements welcome.

# Gather constant vars
CURRENTDIR=${PWD##*/}
GITHUBUSER=$(git config github.user)

if [ -d ".git" ]; then
  rm -rf .git
fi

# Get user input
read -p "Repo Description : " DESCRIPTION
read -p "New repo name (enter for ${PWD##*/}) : " REPONAME
read -p "Git Username (enter for ${GITHUBUSER}) : " GITHUBUSER
echo "You need to enter password twice to validate..."
read -s -p "Enter host password for user '${GITHUBUSER}': " PASSWORD
echo -e ""

if [ "$USER" != "$GITHUBUSER" ]; then
  USER=${GITHUBUSER}
fi

if [ -z "${REPONAME// }" ]; then
  REPONAME=${CURRENTDIR}
fi

readonly REPONAME
readonly GITHUBUSER
readonly DESCRIPTION
readonly PASSWORD

# Curl some json to the github API oh damn we so fancy
curl -u ${USER:-${GITHUBUSER}} https://api.github.com/user/repos -d "{\"name\": \"${REPONAME:-${CURRENTDIR}}\", \"description\": \"${DESCRIPTION}\", \"private\": false, \"has_issues\": true, \"has_downloads\": true, \"has_wiki\": false}"

echo "Here we go..."

# Set the freshly created repo to the origin and push
# You will need to have added your public key to your github account
#git remote set-url origin git@github.com:${USER:-${GITHUBUSER}}/${REPONAME:-${CURRENTDIR}}.git
git remote set-url origin https://${GITHUBUSER}:${PASSWORD}@github.com/${GITHUBUSER}/${CURRENTDIR}.git
git push --set-upstream origin master

#echo "# $REPONAME" >> README.md

git init
git config --global user.email "ernese@sg.ibm.com"
git config --global user.name "Ernese Norelus"

git add .
git commit -m "API Lifecycle and Governance in the Enterprise"
#git remote add origin https://${USER:-${GITHUBUSER}}/${REPONAME:-${CURRENTDIR}}.git
#git remote add origin https://${GITHUBUSER}:${PASSWORD}@github.com/${GITHUBUSER}/${CURRENTDIR}.git
git config remote.origin.url https://${GITHUBUSER}:${PASSWORD}@github.com/${GITHUBUSER}/${REPONAME}.git

#git pull -u origin master
git push -u origin master
#git config -l
