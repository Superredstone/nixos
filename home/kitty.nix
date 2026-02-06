{ pkgs, ... }:
{
  programs.kitty = {
    enable = false;
    settings = {
      enable_audio_bell = false;
      linux_display_server = "x11"; # This is how you get borders in gnome!
    };
    font = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
      size = 16;
    };
    themeFile = "Catppuccin-Mocha";
    extraConfig = "		";
  };
}
