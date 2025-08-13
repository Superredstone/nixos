{ ... }:
{
	services.flatpak.enable = true;

	# Enable CUPS to print documents.
	services.printing.enable = true;
	services.openssh = {
		enable = true;
		ports = [ 22 ];
		settings = {
			PasswordAuthentication = true;
			PermitRootLogin = "no";
		};
	};
}
