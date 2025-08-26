{ ... }:
{
	services.flatpak.enable = true;
	services.xserver.videoDrivers = ["nvidia"];

	# Enable CUPS to print documents.
	services.printing.enable = true;

	# Required for piper to work
	services.ratbagd.enable = true;
}
