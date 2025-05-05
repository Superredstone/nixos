HOSTNAME ?= $(hostname)

switch:
	sudo nixos-rebuild switch --flake ".#${HOSTNAME}"

test:
	sudo nixos-rebuild test --flake ".#${HOSTNAME}"
