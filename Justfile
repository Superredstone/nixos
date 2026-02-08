[default]
_default:
	@just --list

# Show machine name
[group("utils")]
machine:
	@echo "${HOSTNAME}"

# Format and remove dead code 
[group("utils")]
clean-code:
	sudo nix run nixpkgs#deadnix -- -eq
	sudo nix run nixpkgs#nixfmt-tree

# Switch configuration
[group("maintenance")]
switch args="":
	nh os switch -a -H "${HOSTNAME}" . {{args}}

# Initialize a new machine
[group("setup")]
new-machine:
	sudo nixos-rebuild switch --flake .#${HOSTNAME}

# Switch configuration without making it the default boot option 
[group("maintenance")]
test:
	nh os test -a -H "${HOSTNAME}" .

# Update flake.nix
[group("maintenance")]
update flake="":
	nix flake update {{flake}}

# Run update and switch
[group("maintenance")]
upgrade: update switch

# Collect garbage
[group("maintenance")]
clean:
	sudo nix-collect-garbage -d

# Optimise nix store (very long operation) 
[group("maintenance")]
optimise:
	sudo nix-store --optimise

# Run clean and optimise
[group("maintenance")]
clean-all: clean optimise

# List generations
[group("maintenance")]
generations:
	@nh os info

