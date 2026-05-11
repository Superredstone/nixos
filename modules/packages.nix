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
        bintools
        btop
        bun
        busybox
        dig
        distrobox
        docker
        dua
        fd
        file
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
        nixpkgs-review
        nmap
        nodejs
        openssl
        openvpn
        pinentry-tty
        python3
        ripgrep
        rsync
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
        baobab
        bazaar
        blackbox-terminal
        discord
        firefox
        gapless
        gimp
        gnome-boxes
        mpv
        nautilus
        nextcloud-client
        obs-studio
        ollama
        onlyoffice-desktopeditors
        piper
        qbittorrent
        seahorse
        telegram-desktop
        thunderbird
        vlc
        vulkan-tools
      ];

      gamingPackages = lib.optionals gamingSystem [
        arrpc
        cura-appimage
        heroic
        mangohud
        obs-studio 
        openrgb
        prismlauncher
        protonplus
        satisfactorymodmanager
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
        loupe

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
