HOSTNAME ?= $(hostname)

all:
	echo "No command provided"

switch:
	nixos-rebuild switch --flake ".#${HOSTNAME}" --use-remote-sudo

test:
	nixos-rebuild test --flake ".#${HOSTNAME}" --use-remote-sudo
