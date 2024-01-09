{ config, lib, pkgs, dotfilesRoot, ... }:

let
  script = ''
  #!/usr/bin/env bash

  function usage {
    cat <<EOM
Usage: $(basename $0) <command>
Commands:
  sync-system Synchronizes the system against the provided 'configuration.nix'.
  sync-user   Synchronizes the user configuration against the provided 'home.nix'.
  prune       Runs the garbage collector and deletes all old generations.
  edit        Runs the default editor in the config directory.
EOM
    exit 1
  }

  function sync_system {
    sudo nixos-rebuild switch --flake ${dotfilesRoot}
  }

  function sync_user {
    home-manager switch --flake ${dotfilesRoot}
  }

  function prune {
    nix-collect-garbage -d
  }

  function edit {
    cwd=$(pwd)
    cd ${dotfilesRoot}
    $EDITOR
    cd $cwd
  }

  if [ "$#" -lt 1 ]; then
    usage;
  elif [ "$1" = "sync-system" ]; then
    sync_system;
  elif [ "$1" = "sync-user" ]; then
    sync_user;
  elif [ "$1" = "prune" ]; then
    prune;
  elif [ "$1" = "edit" ]; then
    edit;
  else
    usage;
    exit 1;
  fi
  '';
in
{
  home.packages = [
    (pkgs.writeScriptBin "amaterasu" script)
  ];
}
