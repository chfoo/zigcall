#!/bin/dash

NAME=zigcall
VERSION=$(python3 -c "import json
with open('haxelib.json') as file:
    print(json.load(file)['version'])
")
TIMESTAMP=$(date --utc +%Y%m%d-%H%M%S)

mkdir -p out/release/
git archive HEAD -o out/release/$NAME-$VERSION-$TIMESTAMP.zip
