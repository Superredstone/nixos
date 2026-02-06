[default]
_default:
	@just --list

[group("utils")]
machine:
	@echo "${HOSTNAME}"

[group("utils")]
clean-code:
	sudo nix run nixpkgs#deadnix -- -eq
	sudo nix run nixpkgs#nixfmt-tree

[group("maintenance")]
switch args="":
	nh os switch -a -H "${HOSTNAME}" . {{args}}

[group("setup")]
new-machine:
	sudo nixos-rebuild switch --flake .#${HOSTNAME}

[group("maintenance")]
test:
	nh os test -a -H "${HOSTNAME}" .

[group("maintenance")]
update flake="":
	nix flake update {{flake}}

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

