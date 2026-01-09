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

	home = {
		username = "${currentSystemUser}";
		sessionVariables = {
			EDITOR = "nvim";
			BROWSER = "floorp";
			TERMINAL = "kitty";
		};
		packages = [
			pkgs.dconf
		];
		pointerCursor = {
			gtk.enable = true;
			package = pkgs.bibata-cursors;
			size = 12;
			name = "Bibata-Modern-Classic";
		};
	};

	dconf.enable = true;

	services.udiskie.enable = true;

	programs.home-manager.enable = true;

	home.stateVersion = "24.11";
}
