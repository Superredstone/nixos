{
  pkgs,
  # pkgs-25-11,
  pkgs-my-features,
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

  environment.systemPackages =
    with pkgs;
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
        devenv
        dig
        distrobox
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
        pre-commit
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
      ];

      guiPackages = lib.optionals (currentSystemDe != "none") [
        android-studio
        bazaar
        brave
        cinny-desktop
        firefox
        fladder
        gimp
        mpv
        nextcloud-client
        obs-studio
        qbittorrent
        rustdesk
        seahorse
        telegram-desktop
        thunderbird
        vesktop
        vlc
        vulkan-tools
        libreoffice
      ];

      gamingPackages = lib.optionals gamingSystem [
        cura-appimage
        heroic
        obs-studio
        prismlauncher
        satisfactorymodmanager
      ];

      workPackages = lib.optionals workSystem [
        ansible
      ];

      plasmaPackages = lib.optionals (currentSystemDe == "plasma") [
        kdePackages.wallpaper-engine-plugin
      ];

      gnomePackages = lib.optionals (currentSystemDe == "gnome") [
        blackbox-terminal
        gnome-tweaks
        gnomeExtensions.appindicator
        gnomeExtensions.caffeine
        gnomeExtensions.dash-to-dock
        gnomeExtensions.wallpaper-slideshow
      ];

      niriPackages = lib.optionals (currentSystemDe == "niri") [
        gnome-keyring
        loupe
        nautilus
        papers

        inputs.noctalia.packages.${hostSystem}.default
      ];
    in
    basePackages
    ++ guiPackages
    ++ gamingPackages
    ++ workPackages
    ++ plasmaPackages
    ++ gnomePackages
    ++ niriPackages;

}
