#!/bin/bash

# Fast fail the script on failures.
set -e

$(dirname -- "$0")/ensure_dartfmt.sh

# Run the tests.
pub run test

# Run the analyzer.
tool/dart_analyzer.sh

# Install dart_coveralls; gather and send coverage data.
if [ "$COVERALLS_TOKEN" ] && [ "$TRAVIS_DART_VERSION" = "stable" ]; then
  pub global activate dart_coveralls
  pub global run dart_coveralls report \
    --retry 2 \
    --exclude-test-files \
    tool/test_all_for_coverage.dart
fi