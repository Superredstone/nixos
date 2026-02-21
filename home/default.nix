{
  currentSystemUser,
  currentSystemDe,
  pkgs,
  ...
}:
{
  imports = [
    ./fish.nix
    ./git.nix
    ./kitty.nix
    ./mangohud.nix
    ./tmux.nix
    ./vesktop.nix
    ./zoxide.nix
  ]
  ++ (
    if currentSystemDe == "hyprland" then
      ./hyprland
    else
      [ ] ++ (if currentSystemDe == "gnome" then ./gnome.nix else [ ])
  );

  home = {
    username = "${currentSystemUser}";
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "gnome-boxes";
    };
    packages = [
      pkgs.dconf
    ];
    sessionPath = [
      "$HOME/.local/bin"
    ];

    stateVersion = "24.11";
  };

  dconf.enable = true;

  programs.home-manager.enable = true;
}
