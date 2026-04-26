{ inputs, pkgs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.file = {
    "niri-config" = {
      source = ../assets/niri.kdl;
      target = ".config/niri/config.kdl";
    };
  };

  programs.noctalia-shell = {
    enable = true;
    settings = ../assets/noctalia.json;
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    gtk4.theme = null;
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };
  };

  # Fix for steam cursor
  home.file.".local/share/icons/default" = {
    source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic/";
    recursive = true;
  };

  services.udiskie = {
    enable = true;
    settings.program_options.file_manager = "${pkgs.nautilus}/bin/nautilus";
  };
}
