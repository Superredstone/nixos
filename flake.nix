{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:Superredstone/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    spotiflac-cli.url = "github:Superredstone/spotiflac-cli";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixvim,
      spotiflac-cli,
      ...
    }@inputs:
    let
      overlays = [
      ];
      personalEmail = "patrickcanal3@gmail.com";
      username = "r3ddy";
      mkSystem = import ./lib/mksystem.nix {
        inherit
          overlays
          nixvim
          spotiflac-cli
          inputs
          nixpkgs
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
        # Currently supported: plasma, gnome, hyprland and none
        desktopEnvironment = "gnome";
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
      };
    };
}
