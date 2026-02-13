{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    mouse = true;
    extraConfig = ''
            set -g default-terminal "screen-256color"
      			set -g @catppuccin_flavor 'mocha'
      		'';
    plugins = with pkgs; [
      tmuxPlugins.catppuccin
    ];
  };
}
