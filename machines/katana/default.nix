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

	# I still don't know why my configuration fails if i omit this
	system.userActivationScripts = {
		removeConflictingFiles = {
			text = ''
				rm -f /home/${currentSystemUser}/.gtkrc-2.0.backup
			'';
		};
	};

	system.stateVersion = "24.05"; # Did you read the comment?
}
