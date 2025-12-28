#!/bin/bash


branch=$(git rev-parse --abbrev-ref HEAD)

if [[ "$branch" == "release" ]]; then
  echo "Skipping rubocop check on release branch."
  exit 0
fi

echo "Running RuboCop auto-correct..."
rubocop -a

echo "Checking for remaining offenses..."
rubocop

echo "RuboCop has inspectet the code you may now proceed."
exit 0
