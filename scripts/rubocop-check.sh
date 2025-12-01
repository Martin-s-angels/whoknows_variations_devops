#!/bin/bash
echo "Running RuboCop auto-correct..."
rubocop -a

echo "Checking for remaining offenses..."
rubocop

echo "RuboCop has inspectet the code you may now proceed."
exit 0
