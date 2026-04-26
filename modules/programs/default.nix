{
  pkgs,
  gamingSystem,
  currentSystemDe,
  ...
}:
{
  imports = [

  ]
  ++ (if currentSystemDe == "niri" then [ ./niri.nix ] else [ ])
  ++ (if currentSystemDe == "gnome" then [ ./gnome.nix ] else [ ])
  ++ (if currentSystemDe == "plasma" then [ ./plasma.nix ] else [ ]);

  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    steam =
      if gamingSystem then
        {
          enable = true;
          remotePlay.openFirewall = true;
        }
      else
        { };
    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-tty;
      enableSSHSupport = true;
    };
    nh = {
      enable = true;
    };
    hyprland.enable = if currentSystemDe == "hyprland" then true else false;
  };
}
