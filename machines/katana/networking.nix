{ ... }: 
{
	networking.networkmanager.enable = true;
	networking.firewall.allowedUDPPorts = [ 25565 ];
	networking.firewall.allowedTCPPorts = [ 25565 ];
	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;
}
