HOSTNAME = $(shell hostname)

all:
	@echo "No command provided"


machine:
	@echo "${HOSTNAME}"

switch:
	nixos-rebuild switch --flake ".#${HOSTNAME}" --use-remote-sudo

test:
	nixos-rebuild test --flake ".#${HOSTNAME}" --use-remote-sudo

upgrade:
	sudo nix flake update
	nixos-rebuild switch --flake ".#${HOSTNAME}" --use-remote-sudo

clean:
	sudo nix-collect-garbage -d
	sudo nix-store --optimise
