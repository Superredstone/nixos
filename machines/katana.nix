{ ... }:
{
	imports = [
		./hardware/katana.nix
		../modules
	];

	system.stateVersion = "24.05"; # Did you read the comment?
}
