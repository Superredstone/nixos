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
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    hyprland.url = "github:hyprwm/Hyprland";
    spotiflac-cli.url = "github:Superredstone/spotiflac-cli";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixvim,
      millennium,
      spotiflac-cli,
      nur,
      ...
    }@inputs:
    let
      overlays = [
        millennium.overlays.default
        nur.overlays.default
      ];
      personalEmail = "patrickcanal3@gmail.com";
      username = "r3ddy";
      mkSystem = import ./lib/mksystem.nix {
        inherit
          overlays
          nixvim
          millennium
          nur
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
        additionalModules = [
        ];
      };
      nixosConfigurations.workstation = mkSystem "workstation" {
        system = "x86_64-linux";
        user = username;
        email = personalEmail;
        workSystem = true;
        desktopEnvironment = "gnome";
      };
      nixosConfigurations."bomba" = mkSystem "bomba" {
        system = "x86_64-linux";
        email = personalEmail;
        user = username;
        desktopEnvironment = "none";
      };
    };
}
