{ config, pkgs, ... }:
{
	programs.fish = {
		enable = true;
		interactiveShellInit = ''
			set fish_greeting # Disable greeting
			fish_config theme choose Catppuccin\ Mocha
 
			function weather
				curl "wttr.in/Bolzano?0?Q?" 
			end
		'';
	};
}
