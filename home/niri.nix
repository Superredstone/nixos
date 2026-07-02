{ inputs, pkgs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;
    settings = ../assets/noctalia-config.toml;
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    gtk4.theme = null;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };
  };

  qt = {
    enable = true;
    style = {
      name = "adwaita-dark";
    };
  };

  home.file = {
    # Fix for steam cursor
    ".local/share/icons/default" = {
      source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic/";
      recursive = true;
    };
    "niri-config" = {
      source = ../assets/niri.kdl;
      target = ".config/niri/config.kdl";
    };
  };

  services.udiskie = {
    enable = true;
    settings.program_options.file_manager = "${pkgs.nautilus}/bin/nautilus";
  };
}
