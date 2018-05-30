#!/bin/bash

hugo

pushd public
git add -A
git commit -m "$1"
git push
popd

git add -A
git commit -m "$1"
git push
