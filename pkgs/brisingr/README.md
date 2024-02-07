# Brisingr

Small python script which provides aliases and utilities for commands I hate to type.

## Name

The name is inspired by Christopher Paolini's novel Eragon in which the word "Brisingr"
is a spell for "Fire". I liked it.

### Commands

`brisingr sync-system`
: Rebuilds the system in accordance to the active `configuration.nix` file.

`brisingr sync-home`
: Rebuilds the home in accordance to the active home-manager configuration.

`brisingr prune-system`
: Runs the nix garbage collector and deletes ALL previous generations.
: Optionally optimizes the store, if the `--optimize-store` flag is passed.

`brisingr prune-docker`
: Deletes all local docker resources (i.e. containers, images, volumes and networks).

`brisingr upgrade`
: Upgrades flake lock-file and rebuilds the system.

