{ config, lib, pkgs, dotfilesRoot, self, ... }:

let
  script = ''
  #!/usr/bin/env bash

  function usage {
    cat <<EOM
Usage: $(basename $0) <command>
Commands:
  sync-system   Synchronizes the system against the provided 'configuration.nix'.
  sync-user     Synchronizes the user configuration against the provided 'home.nix'.
  prune         Runs the garbage collector and deletes all old generations.
  clean-docker  Deletes ALL docker resources (Containers, Images, Volumes, Networks).
  edit          Runs the default editor in the config directory.
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

  function clean_docker {
    read -p "This action is destructive and cannot be undone. Are you sure? (yes/no) " yn

    case $yn in
      yes ) echo Proceeding;;
      no ) echo Exiting...;
          exit;;
      * ) echo Invalid response;
          exit 1;;
    esac

    echo Stopping all containers...;
    docker stop $(docker ps -aq)
    echo Removing all containers...;
    docker rm $(docker ps -aq)
    echo Removing all images...;
    docker rmi -f $(docker images -qa)
    echo Removing all volumes...;
    docker volume rm $(docker volume ls -qf)
    echo Removing all networks...;
    docker network rm $(docker network ls -q)
    echo Done cleaning docker. Exiting...;
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
  elif [ "$1" = "clean-docker" ]; then
    clean_docker;
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
