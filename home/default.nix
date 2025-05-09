{ currentSystemUser, currentSystemDe, ... }:
{
	imports = [ 
		./nvim
		./tmux.nix
		./fish.nix
		./git.nix
		./kitty.nix
		./zoxide.nix
	] ++ (if currentSystemDe == "hyprland" then [
		./hyprland
	] else []
	);

	home.username = "${currentSystemUser}";

	programs.home-manager.enable = true;

	home.stateVersion = "24.11";
}
