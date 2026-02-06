{ ... }:
{
	networking = {
		networkmanager.enable = true;
		firewall = { 
			allowedTCPPorts = [ 22 5900 ];
			allowedUDPPorts = [ ];
			enable = true;
		};
	};
}
