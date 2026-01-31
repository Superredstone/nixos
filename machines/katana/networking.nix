{ ... }: 
{
	networking = {
		networkmanager.enable = true;
		wireguard.enable = true;
		firewall = {
			checkReversePath = false;
			allowedUDPPorts = [ 25565 ];
			allowedTCPPorts = [ 25565 ];
		};
	};
	hardware.bluetooth = {
		enable = true;	
		powerOnBoot = true;
	};
}
