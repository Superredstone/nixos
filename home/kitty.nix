{ pkgs, config, ... }:
{
	programs.kitty = {
		enable = true;
		settings = {
			enable_audio_bell = false;
		};
		extraConfig = ''
			background_opacity 0.9
			background_blur 1
		'';
	};
}
