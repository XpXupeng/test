#!/bin/bash
VERSION_FILE="../version.h"
VERSION_TEMPLATE_FILE="../version.h.template"
GIT_REMOTE_REPO_NAME="yg_git"
GIT_REMOTE_BRANCH_NAME="reorg_dev"
GIT_HASH_FILE="config.git-hash"

GIT_REMOTE_BRANCH="$GIT_REMOTE_REPO_NAME/$GIT_REMOTE_BRANCH_NAME"

rm -f $VERSION_FILE

git rev-list HEAD | sort > $GIT_HASH_FILE
LOCALVER=`wc -l $GIT_HASH_FILE | awk '{print $1}'`
if [ $LOCALVER \> 1 ] ; then
    VER=`git rev-list $GIT_REMOTE_BRANCH | sort | join $GIT_HASH_FILE - | wc -l | awk '{print $1}'`
    if [ $VER != $LOCALVER ] ; then
        VER="$VER+$(($LOCALVER-$VER))"
    fi
    if git status | grep -q "modified:" ; then
        VER="${VER}M"
    fi
    VER="$VER\_$(git rev-list HEAD -n 1 | cut -c 1-7)-$GIT_REMOTE_BRANCH_NAME"
    GIT_VERSION=r$VER
    TAG_VERSION=`git describe --tags`
else
    GIT_VERSION=
    TAG_VERSION=
    VER="x"
fi
rm -f $GIT_HASH_FILE

cat $VERSION_TEMPLATE_FILE | sed "s/\$FULL_VERSION/$GIT_VERSION/g;s/\$SHORT_VERSION/$TAG_VERSION/g" > $VERSION_FILE

echo "Generated version.h"
