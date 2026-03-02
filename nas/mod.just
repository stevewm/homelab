set quiet := true
set shell := ['bash', '-euo', 'pipefail', '-c']

nas_dir := justfile_dir() + '/nas'
stacks_dir := justfile_dir() + '/stacks'


[private]
default:
    just -l nas
