{
  pkgs,
  lib,
  currentSystemDe,
  ...
}:
let
  libDe = import ../../lib/libde.nix {
    inherit currentSystemDe lib;
  };
in
{
  services = {
    xserver.enable = true;
    xserver.excludePackages = with pkgs; [
      xterm
    ];

    # Display managers
    displayManager = {
      sddm = libDe.ifPlasma {
        enable = true;
        wayland.enable = true;
      };
    };

    # Desktop environments
    desktopManager = {
      plasma6.enable = libDe.ifPlasma true;
    };
  };
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    konsole
  ];
}
