{ config, pkgs, ... }:
{
	programs.fish = {
		enable = true;
		interactiveShellInit = ''
			set fish_greeting # Disable greeting
			alias cd z # Zoxide instead of cd 
		'';
	};
}
