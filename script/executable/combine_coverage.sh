#!/usr/bin/env bash

pwd="$(echo `pwd`)"
escapedLibRelativePath="lib"
if [ $pwd != $MELOS_ROOT_PATH ]; then
  relativePath=${pwd#"$MELOS_ROOT_PATH/"}
  escapedRelativePath="$(echo $relativePath | sed 's/\//\\\//g')"
  escapedLibRelativePath="$escapedRelativePath\/lib"
fi

if grep flutter pubspec.yaml > /dev/null; then
  if [ -d "coverage" ]; then
    # combine line coverage info from package tests to a common file
    if [ ! -d "$MELOS_ROOT_PATH/unit_test_report" ]; then
      mkdir "$MELOS_ROOT_PATH/unit_test_report"
    fi
    sed "s/^SF:lib/SF:$escapedLibRelativePath/g" coverage/lcov.info >> "$MELOS_ROOT_PATH/unit_test_report/lcov.info"
    # rm -rf "coverage"
  fi
fi