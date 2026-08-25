{ enableZram, ... }:
{
  zramSwap.enable = enableZram;
  hardware.keyboard.qmk.enable = true;
}
