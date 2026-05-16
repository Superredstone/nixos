# This file is based on https://github.com/kahlstrm/nixos-config/blob/main/lib/mksystem.nix
{
  overlays,
  nixvim,
  spotiflac-cli,
  sops-nix,
  noctalia,
  inputs,
  nixpkgs,
  nixpkgs-25-11,
  home-manager,
}:
name:
{
  system,
  user,
  email,
  gamingSystem ? false,
  workSystem ? false,
  desktopEnvironment ? "none",
  enableZram ? false,
  additionalModules ? [ ],
}:
let
  nixConfig = ../modules/nix-config/default.nix;
  machineConfig = ../machines/${name}/default.nix;
  HMConfig = ../home;
  systemPackages = ../modules/packages.nix;
  specialArgs = {
    inherit gamingSystem workSystem enableZram nixvim spotiflac-cli sops-nix noctalia inputs additionalModules;
    pkgs-unstable = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs-25-11 = nixpkgs-25-11.legacyPackages.${system};
    currentSystem = system;
    currentSystemName = name;
    currentSystemUser = user;
    currentSystemEmail = email;
    currentSystemDe = desktopEnvironment;
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
    sops-nix.nixosModules.sops
    machineConfig
  ]
  ++ additionalModules;
}
