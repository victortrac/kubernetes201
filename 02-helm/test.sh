#!/bin/bash
function pause() {
  echo -n "Enter to run: $@"
  read
  $@
}

pause echo "1"
pause echo "2"
