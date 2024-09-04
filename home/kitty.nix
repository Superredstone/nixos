{ pkgs, config, ... }:
{
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
}
