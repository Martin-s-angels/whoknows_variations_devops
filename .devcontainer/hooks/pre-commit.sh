
echo "Running RuboCop auto-correct..."
rubocop -a

echo "Checking for remaining offenses..."
rubocop

if [ $? -ne 0 ]; then
  echo "Commit aborted: RuboCop found offenses."
  exit 1
fi

echo "RuboCop passed. Proceeding with commit."
exit 0
