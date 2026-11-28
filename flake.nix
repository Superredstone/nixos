{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-small.url = "github:nixos/nixpkgs/bb11e50a8843e245cd8400e1ae3823bd6f64cc9c";
    nixpkgs-25-11.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-my-features.url = "github:Superredstone/nixpkgs/my-features";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    simple-mailserver.url = "gitlab:simple-nixos-mailserver/nixos-mailserver";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:Superredstone/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixflix = {
      url = "github:kiriwalawren/nixflix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-small,
      nixpkgs-25-11,
      nixpkgs-my-features,
      home-manager,
      nixvim,
      sops-nix,
      nix-cachyos-kernel,
      nixflix,
      simple-mailserver,
      ...
    }@inputs:
    let
      overlays = [
        nix-cachyos-kernel.overlays.pinned
        # beta not in nixpkgs; upstream AppImage is a self-contained sharun/DwarFS bundle, so extract and run its AppRun
        (final: prev: {
          quiver-launcher = prev.stdenvNoCC.mkDerivation rec {
            pname = "quiver-launcher";
            version = "4.0.0-beta.9";
            src = prev.fetchurl {
              url = "https://github.com/tgeorgiadis/quiver-launcher/releases/download/v${version}/QuiverLauncher_${version}_amd64.AppImage";
              hash = "sha256-yXGK8UO6AEjhwffOCsPe1xoUiebs7Qz43ndurbzlh4c=";
            };
            dontUnpack = true;
            dontFixup = true; # bundle ships its own loader and libs
            nativeBuildInputs = [ prev.dwarfs ];
            installPhase = ''
              mkdir -p $out/opt/${pname} $out/bin $out/share/applications
              # shortcut: DwarFS offset is hardcoded, recompute (grep -abo DWARFS) when bumping
              dwarfsextract -i $src -O 1454864 -o $out/opt/${pname}
              ln -s $out/opt/${pname}/AppRun $out/bin/quiver-launcher
              cp -r $out/opt/${pname}/share/icons $out/share/
              cp "$out/opt/${pname}/Quiver Launcher.desktop" $out/share/applications/quiver-launcher.desktop
            '';
            meta.mainProgram = "quiver-launcher";
          };
        })
      ];
      personalEmail = "patrickcanal3@gmail.com";
      username = "r3ddy";
      mkSystem = import ./lib/mksystem.nix {
        inherit
          overlays
          nixvim
          sops-nix
          simple-mailserver
          inputs
          nixpkgs
          nixpkgs-small
          nixpkgs-25-11
          nixpkgs-my-features
          home-manager
          ;
      };
    in
    {
      nixosConfigurations.katana = mkSystem "katana" {
        system = "x86_64-linux";
        user = username;
        email = personalEmail;
        gamingSystem = true;
        # Currently supported: plasma, gnome, niri and none
        desktopEnvironment = [ "niri" ];
        enableZram = true;
        additionalModules = [
        ];
      };
      nixosConfigurations.workstation = mkSystem "workstation" {
        system = "x86_64-linux";
        user = username;
        email = personalEmail;
        workSystem = true;
        desktopEnvironment = [ "gnome" ];
        enableZram = true;
      };
      nixosConfigurations."bomba" = mkSystem "bomba" {
        system = "x86_64-linux";
        email = personalEmail;
        user = username;
        desktopEnvironment = [ "none" ];
        enableZram = true;
        additionalModules = [
          nixflix.nixosModules.default
          simple-mailserver.nixosModules.default
        ];
      };
      nixosConfigurations."frog" = mkSystem "frog" {
        system = "x86_64-linux";
        user = username;
        email = personalEmail;
        workSystem = true;
        desktopEnvironment = [ "gnome" ];
        enableZram = true;
      };
    };
}
