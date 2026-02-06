{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    extraConfig = ''
      			set -g @catppuccin_flavor 'mocha'
      		'';
    plugins = with pkgs; [
      tmuxPlugins.catppuccin
    ];
  };
}
