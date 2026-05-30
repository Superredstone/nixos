{
  currentSystemUser,
  currentSystemDe,
  pkgs,
  ...
}:
{
  imports = [
    ./blackbox.nix
    ./fish.nix
    ./git.nix
    ./kitty.nix
    ./mangohud.nix
    ./tmux.nix
    ./vesktop.nix
    ./zoxide.nix
  ]
  ++ (if currentSystemDe == "gnome" then [ ./gnome.nix ] else [ ])
  ++ (if currentSystemDe == "niri" then [ ./niri.nix ] else [ ]);

  home = {
    username = "${currentSystemUser}";
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "kitty";
    };
    packages = [
      pkgs.dconf
    ];
    sessionPath = [
      "$HOME/.local/bin"
    ];

    stateVersion = "26.05";
  };

  dconf.enable = true;

  programs.home-manager.enable = true;
}
