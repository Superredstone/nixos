{ pkgs, config, ... }:
{
	programs.tmux = {
		enable = true;
		escapeTime = 0;
		extraConfig = ''
			set-option -g mouse on
			set -g @catppuccin_flavor 'mocha'
		'';
		plugins = with pkgs; [ 
			tmuxPlugins.catppuccin
		];
	};
}
