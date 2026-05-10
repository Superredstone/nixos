{
  pkgs,
  # pkgs-25-11,
  lib,
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

  environment.systemPackages = with pkgs;
    let
      hostSystem = pkgs.stdenv.hostPlatform.system;
      basePackages = [
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
        xwayland-satellite
        zip
        zoxide
        zulu

        # Man pages
        man-pages

        vim # The only and one great editor
        inputs.nixvim.packages.${stdenv.hostPlatform.system}.default # The only and one great editor improved even further
        inputs.spotiflac-cli.packages.${stdenv.hostPlatform.system}.default
      ];

      guiPackages = lib.optionals (currentSystemDe != "none") [
        vulkan-tools
        baobab
        bazaar
        blackbox-terminal
        discord
        firefox
        gapless
        gnome-boxes
        mpv
        nautilus
        nextcloud-client
        obs-studio
        ollama
        piper
        seahorse
        telegram-desktop
        thunderbird
      ];

      gamingPackages = lib.optionals gamingSystem [
        cura-appimage
        heroic
        mangohud
        openrgb
        prismlauncher
        protonplus
        satisfactorymodmanager
        arrpc
      ];

      workPackages = lib.optionals workSystem [
        android-studio
        ansible
        virt-manager
      ];

      plasmaPackages = lib.optionals (currentSystemDe == "plasma") [
        kdePackages.wallpaper-engine-plugin
      ];

      hyprlandPackages = lib.optionals (currentSystemDe == "hyprland") [
        brightnessctl
        hyprpaper
        pamixer
        pavucontrol
        kdePackages.dolphin
      ];

      gnomePackages = lib.optionals (currentSystemDe == "gnome") [
        gnome-tweaks
        gnomeExtensions.appindicator
        gnomeExtensions.caffeine
        gnomeExtensions.dash-to-dock
        gnomeExtensions.wallpaper-slideshow
      ];

      niriPackages = lib.optionals (currentSystemDe == "niri") [
        gnome-keyring
        inputs.noctalia.packages.${hostSystem}.default
      ];
    in
    basePackages
      ++ guiPackages
      ++ gamingPackages
      ++ workPackages
      ++ plasmaPackages
      ++ hyprlandPackages
      ++ gnomePackages
      ++ niriPackages;

}
