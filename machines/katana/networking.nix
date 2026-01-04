{ ... }: 
{
	networking.networkmanager.enable = true;
	networking.firewall = {
		checkReversePath = false;
		allowedUDPPorts = [ 25565 1194 ];
		allowedTCPPorts = [ 25565 443 ];
	};
	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;
	networking.wireguard.enable = true;
}
