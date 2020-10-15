#!/bin/env bats

source 'gradle-install.sh'

@test "check if file exist" {
  [[ -f 'gradle-install.sh' ]]
}

@test "check file's executives" {
  [[ -x 'gradle-install.sh' ]] 
}

@test "sudochecker" {
  run sudoChecker 	
  [ "$?" == 0 ]
}

@test "connection check" {
  run connectionCheck  
  [ "$status" == '' ]
}

