{ currentSystemUser, ... }:
{
	imports = [
		./hardware.nix
		./boot.nix
		./nvidia.nix
		./services.nix
		./virtualisation.nix
		./networking.nix
	];

	networking.hostName = "katana"; # Define your hostname.

	system.stateVersion = "24.05"; # Did you read the comment?
}
