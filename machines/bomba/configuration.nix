# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.networkmanager.enable = true;

	time.timeZone = "Europe/Rome";

	nixpkgs.config.allowUnfree = true;

	services = {
		openssh.enable = true;
		udisks2.enable = true;
	};

	networking.firewall.allowedTCPPorts = [ 22 ];
	networking.firewall.allowedUDPPorts = [ ];
	networking.firewall.enable = true;
}
