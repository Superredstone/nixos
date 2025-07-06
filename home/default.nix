{ currentSystemUser, currentSystemDe, ... }:
{
	imports = [ 
		./fish.nix
		./git.nix
		./gnome.nix
		./kitty.nix
		./nvim
		./tmux.nix
		./zoxide.nix
	] ++ (if currentSystemDe == "hyprland" then [
		./hyprland
	] else []
	);

	home.username = "${currentSystemUser}";
	home.sessionVariables = {
		EDITOR = "nvim";
		BROWSER = "floorp";
		TERMINAL = "kitty";
	};

	programs.home-manager.enable = true;

	home.stateVersion = "24.11";
}
