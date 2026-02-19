{
  pkgs,
  gamingSystem,
  currentSystemDe,
  ...
}:
{
  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    steam =
      if gamingSystem then
        {
          enable = true;
          # package = pkgs.steam-millennium;
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
