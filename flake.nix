{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-25-11.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-my-features.url = "github:Superredstone/nixpkgs/my-features";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:Superredstone/nixvim";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixflix = {
      url = "github:kiriwalawren/nixflix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-25-11,
      nixpkgs-my-features,
      home-manager,
      nixvim,
      sops-nix,
      nix-cachyos-kernel,
      noctalia,
      nixflix,
      ...
    }@inputs:
    let
      overlays = [
        nix-cachyos-kernel.overlays.pinned
      ];
      personalEmail = "patrickcanal3@gmail.com";
      username = "r3ddy";
      mkSystem = import ./lib/mksystem.nix {
        inherit
          overlays
          nixvim
          sops-nix
          noctalia
          inputs
          nixpkgs
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
        desktopEnvironment = "niri";
        enableZram = true;
        additionalModules = [
        ];
      };
      nixosConfigurations.workstation = mkSystem "workstation" {
        system = "x86_64-linux";
        user = username;
        email = personalEmail;
        workSystem = true;
        desktopEnvironment = "gnome";
        enableZram = true;
      };
      nixosConfigurations."bomba" = mkSystem "bomba" {
        system = "x86_64-linux";
        email = personalEmail;
        user = username;
        desktopEnvironment = "none";
        enableZram = true;
        additionalModules = [
          nixflix.nixosModules.default
        ];
      };
      nixosConfigurations."frog" = mkSystem "frog" {
        system = "x86_64-linux";
        user = username;
        email = personalEmail;
        workSystem = true;
        desktopEnvironment = "gnome";
        enableZram = true;
      };
    };
}
