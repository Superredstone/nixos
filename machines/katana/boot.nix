{ pkgs, ... }:
{
	boot = {
		loader.systemd-boot.enable = true;
		loader.efi.canTouchEfiVariables = true;
		loader.systemd-boot.configurationLimit = 10;
  		initrd = {
			luks.devices."luks-563ebcd9-614b-460f-af9a-5cf1d9c8bef5".device = "/dev/disk/by-uuid/563ebcd9-614b-460f-af9a-5cf1d9c8bef5";
			verbose = false;
		};
		kernelPackages = pkgs.linuxPackages_zen; # pkgs.linuxPackages_latest;
		consoleLogLevel = 3;
		kernelParams = [
			"quiet"
			"splash"
			"intremap=on"
			"boot.shell_on_fail"
			"udev.log_priority=3"
			"rd.systemd.show_status=auto"
		];	

		plymouth.enable = true;
	};
}
