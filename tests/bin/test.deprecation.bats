#!/usr/bin/env bats

@test "deprecation notice goes to stderr" {
  run bash -c "awslocal --version 2>&1 >/dev/null"
  [ "$status" -eq 0 ]
  [[ "$output" == *"WARNING: 'awslocal' is deprecated. Use 'lstk aws' instead."* ]]
}

@test "deprecation notice stays out of stdout" {
  run bash -c "awslocal --version 2>/dev/null"
  [ "$status" -eq 0 ]
  [[ "$output" != *"deprecated"* ]]
}

@test "deprecation notice can be turned off" {
  run bash -c "DISABLE_DEPRECATION_NOTICE=1 awslocal --version 2>&1"
  [ "$status" -eq 0 ]
  [[ "$output" != *"'awslocal' is deprecated"* ]]
}
