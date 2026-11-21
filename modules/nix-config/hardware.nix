{ enableZram, lib, ... }:
{
  zramSwap.enable = enableZram;
  # Zram swap is cheap, so prefer it over dropping page cache and skip readahead
  boot.kernel.sysctl = lib.mkIf enableZram {
    "vm.swappiness" = 180;
    "vm.page-cluster" = 0;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
  };
  hardware.keyboard.qmk.enable = true;
}
