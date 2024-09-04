{ config, pkgs, ... }:
{
	imports = [ 
		./tmux.nix
		./fish.nix
		./git.nix
		./kitty.nix
	];

	home.username = "r3ddy";

	programs.home-manager.enable = true;
	programs.zoxide.enable = true;

	home.stateVersion = "24.11";
}
