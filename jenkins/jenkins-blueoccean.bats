!#/bin/env vats

# docker image of Bat is at 'docker run -it bats/bats:latest --version
@test "check if script is executable" {
  
}

@test "check aptDependencyInstall" {
  run aptInstallDepency && ec=$?
  [ ec == 0 ]
}
