{ pkgs, ... }:
{
	programs.kitty = {
		enable = true;
		settings = {
			enable_audio_bell = false;
		};
		font = {
			package = pkgs.nerd-fonts.jetbrains-mono;
			name = "JetBrainsMono Nerd Font";
			size = 16;
		};
		themeFile = "Catppuccin-Mocha";
		extraConfig = ''
		'';
	};
}
