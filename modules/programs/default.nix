{
  pkgs,
  lib,
  gamingSystem,
  currentSystemDe,
  ...
}:
let
  desktopEnvironments = builtins.filter (environment: environment != "none") currentSystemDe;
in
{
  imports = [

  ]
  ++ (if builtins.elem "niri" currentSystemDe then [ ./niri.nix ] else [ ])
  ++ (if builtins.elem "gnome" currentSystemDe then [ ./gnome.nix ] else [ ])
  ++ (if builtins.elem "plasma" currentSystemDe then [ ./plasma.nix ] else [ ]);

  services.displayManager.defaultSession = lib.mkIf (desktopEnvironments != [ ]) (
    lib.mkForce (builtins.head desktopEnvironments)
  );

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
          extraCompatPackages = with pkgs; [ proton-ge-bin ];
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
    bash.shellAliases = {
      dev = "nix develop --command 'fish'";
    };
  };
}
