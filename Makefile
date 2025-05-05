HOSTNAME ?= $(hostname)

all:
	echo "No command provided"

switch:
	sudo nixos-rebuild switch --flake ".#${HOSTNAME}"

test:
	sudo nixos-rebuild test --flake ".#${HOSTNAME}"
