"""Personal utility to manage my own nixOS setup and other services."""

__version__ = "1.0.0"

import tomllib
import click
import subprocess
import sys

DOTFILES_DIR = "/home/kirsch/Repositories/dotfiles"

@click.group()
def cli():
    pass

@cli.command()
def sync_system():
    """
    Synchronizes the system against the active "configuration.nix" file.
    """
    shell_cmd = f"sudo nixos-rebuild switch --flake {DOTFILES_DIR}"
    subprocess.run(shell_cmd, shell=True, check=True)


@cli.command()
def sync_home():
    """
    Synchronizes the home against the active home-manager configuration.
    """
    shell_cmd = f"home-manager switch --flake {DOTFILES_DIR}"
    subprocess.run(shell_cmd, shell=True, check=True, capture_output=True)


@cli.command()
@click.option("--optimize-store", is_flag=True, default=False, help="Whether to optimize the nix-store.")
def prune_system(optimize_store: bool):
    """
    Runs the garbage collector and optionally optimizes the nix-store.
    """
    subprocess.run("nix-collect-garbage -d", shell=True, check=True)

    if optimize_store:
        subprocess.run("nix-store --optimize", shell=True, check=True)


@cli.command()
@click.confirmation_option(prompt="Are you sure you want to release all local docker resources?")
def prune_docker():
    """
    Aggressively releases all local resource occupied by docker.
    """
    result = subprocess.run(
        "docker ps -aq",
        shell=True,
        check=True,
        capture_output=True,
        text=True
    )

    containers = result.stdout.split()

    for container in containers:
        subprocess.run(f"docker stop {container}", shell=True, check=True)
        subprocess.run(f"docker rm {container}", shell=True, check=True)

    result = subprocess.run(
        "docker volume ls -q",
        shell=True,
        check=True,
        capture_output=True,
        text=True
    )

    volumes = result.stdout.split()
    for volume in volumes:
        subprocess.run(f"docker volume rm {volume}", shell=True, check=True)

    result = subprocess.run(
        "docker images -qa",
        shell=True,
        check=True,
        capture_output=True,
        text=True
    )

    images = result.stdout.split()
    for image in images:
        subprocess.run(f"docker rmi -f {image}", shell=True, check=True)

    result = subprocess.run(
        "docker network ls --format \"{{.ID}},{{.Name}}\"",
        shell=True,
        check=True,
        capture_output=True,
        text=True
    )

    default_networks = ["bridge", "host", "none"]
    networks = [network.split(",") for network in result.stdout.split()]
    for network_id, network_name in networks:
        if network_name not in default_networks:
            subprocess.run(f"docker network rm {network_id}", shell=True, check=True)


@cli.command()
def upgrade():
    """
    Upgrades the flake.lock and builds the system.
    """
    shell_cmd = f"nix flake update {DOTFILES_DIR}"
    subprocess.run(shell_cmd, shell=True, check=True)


def main():
    cli()
    sys.exit()

if __name__ == "__main__":
    main()

