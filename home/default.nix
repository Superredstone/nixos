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
    ./tmux.nix
    ./zoxide.nix
  ]
  ++ (
    if !(builtins.elem "none" currentSystemDe) then
      [
        ./mangohud.nix
      ]
    else
      [ ]
  )
  ++ (if builtins.elem "gnome" currentSystemDe then [ ./gnome.nix ] else [ ])
  ++ (if builtins.elem "niri" currentSystemDe then [ ./niri.nix ] else [ ]);

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
