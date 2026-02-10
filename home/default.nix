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
    ./gnome.nix
    ./kitty.nix
    ./mangohud.nix
    ./tmux.nix
    ./vesktop.nix
    ./zoxide.nix
  ]
  ++ (
    if currentSystemDe == "hyprland" then
      [
        ./hyprland
      ]
    else
      [ ]
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
    pointerCursor = {
      enable = false;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
    };
  };

  dconf.enable = true;

  programs.home-manager.enable = true;

  home.stateVersion = "24.11";
}
