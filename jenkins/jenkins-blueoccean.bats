#!/bin/env bats

# docker image of Bat is at 'docker run -it bats/bats:latest --version
source jenkins-blueoccean.sh

@test "check if script is executable" {
  [ -x 'jenkins-blueoccean.sh' ]
}

@test "check yumDependencyInstall" {
  skip
  run sudo yumInstallDependency;
  [ "$status" -eq 0 ]
}

@test "build persistent volumne" {
  run createVolume
  [ "$status" -eq 0 ]
}

@test "check output functionality" {
  run  output 'test' 80
  [ "$status" -eq 0 ]
}

@test "check docker networking" {
  run createNetwork
  [ "$status" -eq 0 ]
  echo "$output"
}

@test "Create nested docker" {
  run createNestedDocker
  [ "$status" -eq 0 ] 
}

@test "Create blueoccean container" {
  run createJenkinsBlueoccean
  [ "$status" -eq 0 ]
}
