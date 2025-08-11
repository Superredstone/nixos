{ ... }: 
{
	networking.networkmanager.enable = true;
	networking.firewall.allowedUDPPorts = [ 8000 ];
	networking.firewall.allowedTCPPorts = [ 8000 ];
	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;
}
