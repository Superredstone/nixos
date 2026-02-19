# This file is based on https://github.com/kahlstrm/nixos-config/blob/main/lib/mksystem.nix
{
  overlays,
  nixvim,
  millennium,
  spotiflac-cli,
  inputs,
  nixpkgs,
  home-manager,
}:
name:
{
  system,
  user,
  email,
  gamingSystem ? false,
  workSystem ? false,
  desktopEnvironment ? "",
  enableZram ? false,
  additionalModules ? [ ],
}:
let
  nixConfig = ../modules/nix-config/default.nix;
  machineConfig = ../machines/${name}/default.nix;
  HMConfig = ../home;
  systemPackages = ../modules/packages.nix;
  specialArgs = {
    pkgs-stable = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    currentSystem = system;
    currentSystemName = name;
    currentSystemUser = user;
    currentSystemEmail = email;
    currentSystemDe = desktopEnvironment;
    gamingSystem = gamingSystem;
    workSystem = workSystem;
    enableZram = enableZram;
    nixvim = nixvim;
    millennium = millennium;
    spotiflac-cli = spotiflac-cli;
    inputs = inputs;
    additionalModules = additionalModules;
  };
in
nixpkgs.lib.nixosSystem {
  inherit system specialArgs;
  modules = [
    { nixpkgs.overlays = overlays; }
    nixConfig
    systemPackages
    home-manager.nixosModules.home-manager
    {
      home-manager.backupFileExtension = "backup";
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${user} = import HMConfig;
      home-manager.extraSpecialArgs = specialArgs;
      home-manager.sharedModules = [
      ];
    }
    machineConfig
  ]
  ++ additionalModules;
}
