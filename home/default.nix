{ currentSystemUser, currentSystemDe, pkgs, ... }:
{
	imports = [ 
		./fish.nix
		./git.nix
		./gnome.nix
		./kitty.nix
		./mangohud.nix
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
	home.packages = [
		pkgs.dconf
	];

	dconf.enable = true;

	services.udiskie.enable = true;

	programs.home-manager.enable = true;

	home.stateVersion = "24.11";
}
