{ ... }:
{
	imports = [ 
		./nvim
		./tmux.nix
		./fish.nix
		./git.nix
		./kitty.nix
		./zoxide.nix
	];

	home.username = "r3ddy";

	programs.home-manager.enable = true;

	home.stateVersion = "24.11";
}
