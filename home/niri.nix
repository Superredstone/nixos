{ inputs, ... }:
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
}
