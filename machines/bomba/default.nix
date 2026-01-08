{ ... }: 
{
	imports = [ 
		./configuration.nix
		./hardware.nix
		./virtualisation.nix
	];

	networking.hostName = "bomba";

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

  	system.stateVersion = "25.05"; # Did you read the comment?
}
