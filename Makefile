HOSTNAME = $(shell hostname)

all:
	@echo "No command provided"


machine:
	@echo "${HOSTNAME}"

switch:
	nh os switch -a -H "${HOSTNAME}" . 

test:
	nh os test -a -H "${HOSTNAME}" .

update:
	sudo nix flake update

upgrade: update switch

clean:
	sudo nix-collect-garbage -d
	sudo nix-store --optimise
