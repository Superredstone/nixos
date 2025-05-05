{ pkgs, ... }:
{
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.systemd-boot.configurationLimit = 10;
	boot.initrd.luks.devices."luks-332a07bd-65fb-4d91-91ba-fe3f594063b1".device = "/dev/disk/by-uuid/332a07bd-65fb-4d91-91ba-fe3f594063b1";
	boot.kernelPackages = pkgs.linuxPackages_latest;
}
