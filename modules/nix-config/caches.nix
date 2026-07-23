{ ... }:
{
  nix.settings = {
    substituters = [
      "https://cache.nixos.org"
      "https://cache.garnix.io"
      "https://nixvim-superredstone.cachix.org"
      "https://noctalia.cachix.org"
      "https://attic.xuyh0120.win/lantian"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "nixvim-superredstone.cachix.org-1:mEXHVxEv5dKka3FOxTMFDfdk/DJ0baydsahi+zZIcQE="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    trusted-users = [
      "root"
      "@wheel"
    ];
  };
}
