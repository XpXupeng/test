#!/bin/bash
branch_name=`git rev-parse --abbrev-ref HEAD` #获得当前分支名称
version_show_name="v`date +%y%m%d%H%M`_${branch_name:0:3}"

if [[ -z $(git status -s) ]]; then
    echo "Will build software for version $version_show_name ."
else
    git status -s
    echo "code base has uncommitted changes. commit first."
    exit
fi

git tag $version_show_name
version=`git describe --tags`_$moudle
echo $version
