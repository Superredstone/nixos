{ ... }: 
{
	networking.networkmanager.enable = true;
	networking.firewall.allowedUDPPorts = [ 8000 23 ];
	networking.firewall.allowedTCPPorts = [ 8000 23 ];
	networking.useDHCP = false;
	# networking.bridges = {
	# 	"br0" = {
	# 		interfaces = [ "eno1" ];
	# 	};
	# };
	# networking.interfaces.br0.ipv4.addresses = [{
	# 	address = "192.168.1.235";
	# 	prefixLength = 24;
	# }];
	networking.defaultGateway = "192.168.1.1";
	networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];
	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;
}
