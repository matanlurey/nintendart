#!/bin/bash

# Fast fail the script on failures.
set -e

# Run the analyzer on STRONG mode to detect analysis issues.
find lib test -name *.dart | xargs dartanalyzer --fatal-hints --fatal-warnings
