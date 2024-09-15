{ config, pkgs, ... }:
{
	programs.fish = {
		enable = true;
		interactiveShellInit = ''
			set fish_greeting # Disable greeting
			function weather
				curl "wttr.in/Bolzano?0?Q?" 
			end
		'';
	};
}
