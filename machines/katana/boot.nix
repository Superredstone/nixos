{ pkgs, ... }:
{
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.systemd-boot.configurationLimit = 10;
  	boot.initrd.luks.devices."luks-563ebcd9-614b-460f-af9a-5cf1d9c8bef5".device = "/dev/disk/by-uuid/563ebcd9-614b-460f-af9a-5cf1d9c8bef5";
	boot.kernelPackages = pkgs.linuxPackages_zen; # pkgs.linuxPackages_latest;
}
