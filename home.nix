{ config, pkgs, ... }:
{
	home.username = "r3ddy";
	programs.home-manager.enable = true;
	
	programs.git = {
		enable = true;
		userName = "Superredstone";
		userEmail = "patrickcanal3@gmail.com";
	};
	programs.fish = {
		enable = true;
		interactiveShellInit = ''
			set fish_greeting # Disable greeting
		'';
	};
	programs.kitty = {
		enable = true;
		font = { 
			name = "JetBrainsMono Nerd Font";
			size = 16;
		};
		theme = "Catppuccin-Mocha";
		settings = {
			enable_audio_bell = false;
		};
	};
	programs.tmux.enable = true;
	home.stateVersion = "24.11";
}
