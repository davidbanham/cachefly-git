#!/bin/bash

# Add the names of your repositories here. The expected use case is that the repos are stored in /home/cacheflyupdater/. You can change that in the code if you like.

REPOS[0]=oim-cdn-motd
REPOS[1]=oim-cdn-bin
REPOS[2]=oim-cdn-creative

# Add the directory you'd like to correspond to the repo on the cachefly server. Make sure you place it in the correct position in the array. Yes it's hacky, but it works and how often will you be changing it?

TARGETDIR[0]=motd
TARGETDIR[1]=bin
TARGETDIR[2]=creative

# Your rsync username

CFUSERNAME=oim

# Things happen

k=0
for i in ${REPOS[@]}
do
  OUTPUT=`cd /home/cacheflyupdater/${REPOS[$k]}/ && git pull`

# The if loop is to avoid pinging cachefly even when there's been no change to the git repo. If you're concerned about the cachefly files being updated from elsewhere you may wish to change this behaviour.

  if [[ $OUTPUT != "Already up-to-date." ]]; then
    rsync -avv --delete --progress /home/cacheflyupdater/${REPOS[$k]}/ $CFUSERNAME@ftp.cachefly.com:/web/${TARGETDIR[$k]}/ --exclude .git --exclude .project
  fi

# Increment k by one. Surely this shouldn't be this hard in bash. Am I missing something really obvious?

k=`expr $k + 1`
done

