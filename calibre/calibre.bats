#!/bin/env bats 


@test 'checkContainer module check' {
  source calibre.sh
  run checkContainer 'calibre-web'
  [ "$status" -eq 0 ]
} 
