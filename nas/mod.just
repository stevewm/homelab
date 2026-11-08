set quiet := true
set shell := ['bash', '-euo', 'pipefail', '-c']

nas_dir := justfile_dir() + '/nas'
containers_dir := justfile_dir() + '/containers'


[private]
default:
    just -l nas
