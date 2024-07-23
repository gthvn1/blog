#!/bin/sh

cd my-blog
mkdocs build
rm -rf ../docs
mv site ../docs
