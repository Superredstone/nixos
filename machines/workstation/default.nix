{ currentSystemUser, ... }:
{
	imports = [
		./hardware.nix
		./services.nix
		./virtualisation.nix
		./networking.nix
	];

	networking.hostName = "workstation"; # Define your hostname.

	boot.loader = {
		systemd-boot.enable = true;
		efi.canTouchEfiVariables = true;
	};

	system.stateVersion = "24.11"; # Did you read the comment?
}
