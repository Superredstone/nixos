[default]
_default:
    @just --list

[group("utils")]
machine:
	@echo "${HOSTNAME}"

[group("maintenance")]
switch:
	nh os switch -a -H "${HOSTNAME}" . 

[group("setup")]
new-machine:
	sudo nixos-rebuild switch --flake .#${HOSTNAME}

[group("maintenance")]
test:
	nh os test -a -H "${HOSTNAME}" .

[group("maintenance")]
update:
	sudo nix flake update

[group("maintenance")]
upgrade: update switch

[group("maintenance")]
clean:
	sudo nix-collect-garbage -d

[group("maintenance")]
optimise:
	sudo nix-store --optimise

[group("maintenance")]
clean-all: clean optimise

[group("maintenance")]
generations:
	@nh os info
