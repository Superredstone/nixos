{
  pkgs,
  gamingSystem,
  workSystem,
  currentSystemDe,
  ...
}@inputs:
{
  imports = [
    ./programs
  ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    with pkgs;
    [
      # CLI utils
      appimage-run
      bat
      btop
      bun
      busybox
      distrobox
      docker
      dua
      fd
      fish
      fzf
      gh
      git
      gitlab-ci-local
      gnumake
      htop
      jq
      just
      killall
      krabby
      lazygit
      nmap
      nodejs
      openssl
      openvpn
      pinentry-tty
      python3
      ripgrep
      sops
      tree
      unzip
      wget
      wl-clipboard
      zip
      zoxide
      zulu

      # Man pages
      man-pages

      vim # The only and one great editor
      inputs.nixvim.packages.${stdenv.hostPlatform.system}.default # The only and one great editor improved even further

      inputs.spotiflac-cli.packages.${stdenv.hostPlatform.system}.default
    ]
    ++ (
      if currentSystemDe != "none" then
        [
          # Video card
          vulkan-tools

          # GUI applications
          baobab
          bazaar
          blackbox-terminal
          discord
          firefox
          gapless
          gnome-boxes
          mpv
          nextcloud-client
          obs-studio
          piper
          seahorse
          telegram-desktop
          thunderbird

          (delfin.overrideAttrs (old: {
            src = fetchFromCodeberg {
              repo = "delfin";
              owner = "Fisch";
              rev = "0c4edad17189943162bbc98304e0211f765ba70e";
              hash = "sha256-xe1US0Yk6hpRN57qx0yhuwolope/j4UkDtIGliOO4Gc=";
            };
          }))
        ]
      else
        [ ]
    )
    ++ (
      if gamingSystem then
        [
          cura-appimage
          heroic
          mangohud
          openrgb
          prismlauncher
          protonplus
          satisfactorymodmanager

          # Required for Discord RPC
          arrpc
        ]
      else
        [ ]
    )
    ++ (
      if workSystem then
        [
          android-studio
          ansible
          virt-manager
        ]
      else
        [ ]
    )
    ++ (
      if currentSystemDe == "plasma" then
        [
          kdePackages.wallpaper-engine-plugin
        ]
      else
        [ ]
    )
    ++ (
      if currentSystemDe == "hyprland" then
        [
          # Hyprland
          brightnessctl
          hyprpaper
          pamixer
          pavucontrol
          kdePackages.dolphin
        ]
      else
        [ ]
    )
    ++ (
      if currentSystemDe == "gnome" then
        [
          gnome-tweaks
          gnomeExtensions.appindicator
          gnomeExtensions.caffeine
          gnomeExtensions.dash-to-dock
          gnomeExtensions.wallpaper-slideshow
        ]
      else
        [ ]
    );

}
