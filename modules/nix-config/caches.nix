{ ... }:
{
  nix.settings = {
    substituters = [
      "https://cache.nixos.org"
      "https://nixvim-superredstone.cachix.org"
      "https://spotiflac-cli.cachix.org"
      "https://attic.xuyh0120.win/lantian"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nixvim-superredstone.cachix.org-1:mEXHVxEv5dKka3FOxTMFDfdk/DJ0baydsahi+zZIcQE="
      "spotiflac-cli.cachix.org-1:UgpE8P0TO8NuF03vF117r/vgTkjq13Z3JqGzaQdC7xE="
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
    ];
    trusted-users = [
      "root"
      "@wheel"
    ];
  };
}
