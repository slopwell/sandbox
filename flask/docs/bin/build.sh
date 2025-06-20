#!/usr/bin/env bash

set -e

# /docs
basedir=$(cd "$(dirname "$0")/.."; pwd)
distD="$basedir/dist"
sourceD="$basedir/source"
releaseD="$basedir/release"

cp "$sourceD/conf.py" "$distD/" 
cp "$sourceD/index.rst" "$distD/"

sphinx-apidoc --force --output-dir "$basedir/dist" "$basedir"

sphinx-build -M html "$sourceD" "$releaseD"
