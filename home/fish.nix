{ config, pkgs, ... }:
{
	programs.fish = {
		enable = true;
		interactiveShellInit = ''
			fish_config theme choose Catppuccin\ Mocha

			function fish_greeting 
				krabby random --no-title --padding-left 2
			end
 
			function weather
				curl "wttr.in/Bolzano?0?Q?" 
			end
		'';
	};
}
