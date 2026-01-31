{ ... }: 
{
	networking = {
		networkmanager.enable = true;
		firewall = { 
			allowedTCPPorts = [ 22 ];
			allowedUDPPorts = [ ];
			enable = true;
		};
	};
}
