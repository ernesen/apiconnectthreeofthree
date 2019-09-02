#!/bin/sh

# git add -A ## both combined into a single command <git commit -a -m "msg">

if [ "$1" != "" ]; then
    #echo "git commit -m \"$1\""
	git commit -a -m "$1"
else
    #echo "git commit -m \"latest updates to the Kubernetes Webinar Series\""
	git commit -a -m "Adding API Lifecycle and Governance in the Enterprise"
fi

# git pull origin master ## only applicable if I had more than one user using this repo.
git push origin master

#git push origin master

