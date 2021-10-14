#!/bin/bash

# This script can be used to run flutter test for a given directory (defaults to the current directory)
# It will exclude generated code and translations (mimicking the ci) and open the coverage report in a
# new window once it has run successfully.
#
# To run in main project:
# ./utils/coverage.sh
#
# To run in other directory:
# ./utils/coverage.sh ./path/to/other/project

set -e

PROJECT_PATH="${1:-.}"
PROJECT_COVERAGE=./coverage/lcov.info

cd ${PROJECT_PATH}

rm -rf coverage
if grep -q "flutter:" pubspec.yaml; then
    flutter --version
    flutter test --no-pub --test-randomize-ordering-seed random --coverage -j 28
else
    dart --version
    dart test --coverage=coverage && pub run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info --packages=.packages --report-on=lib
fi
lcov --remove ${PROJECT_COVERAGE} -o ${PROJECT_COVERAGE} \
    '**/*.g.dart' \
    '**/l10n/*.dart' \
    '**/l10n/**/*.dart' \
    '**/main/bootstrap.dart' \
    '**/*.gen.dart'
genhtml ${PROJECT_COVERAGE} -o coverage | tee ./coverage/output.txt

COV_LINE=$(tail -2 ./coverage/output.txt | head -1)
SUB='100.0%'

if [[ "$COV_LINE" == *"$SUB"* ]]; then
    echo "The coverage is 100%"
else
    echo "Coverage is below 100%! Run ./tool/coverage.sh for this package to check which lines are not covered."
    echo $COV_LINE
    open ./coverage/index.html
fi
