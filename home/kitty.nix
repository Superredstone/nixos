{ pkgs, currentSystemDe, ... }:
{
  programs.kitty = {
    enable = currentSystemDe != "none";
    themeFile = "Catppuccin-Mocha";
    extraConfig = "		";
    enableGitIntegration = true;
    settings = {
      enable_audio_bell = false;
      hide_window_decorations = true;
      # linux_display_server = "x11"; # This is how you get borders in gnome!
    };
    font = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
  };
}
