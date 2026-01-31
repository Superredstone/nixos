{ ... }: 
{
	networking = {
		networkmanager.enable = true;
		firewall.allowedUDPPorts = [ 8000 ];
		firewall.allowedTCPPorts = [ 8000 ];
		nameservers = [ "1.1.1.1" "1.0.0.1" ];
	};
}
