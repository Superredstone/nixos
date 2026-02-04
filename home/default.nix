{ currentSystemUser, currentSystemDe, pkgs, catppuccin, ... }:
{
	imports = [ 
		./catppuccin.nix
		./fish.nix
		./git.nix
		./gnome.nix
		./kitty.nix
		./mangohud.nix
		./tmux.nix
		./zoxide.nix
		catppuccin.homeModules.catppuccin
	] ++ (if currentSystemDe == "hyprland" then [
		./hyprland
	] else []
	);

	home = {
		username = "${currentSystemUser}";
		sessionVariables = {
			EDITOR = "nvim";
			BROWSER = "firefox";
			TERMINAL = "gnome-boxes";
		};
		packages = [
			pkgs.dconf
		];
		pointerCursor = {
			enable = false;
			package = pkgs.bibata-cursors;
			name = "Bibata-Modern-Classic";
		};
	};

	dconf.enable = true;

	programs.home-manager.enable = true;

	home.stateVersion = "24.11";
}
