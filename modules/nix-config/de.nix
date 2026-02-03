{ pkgs, lib, currentSystemDe, ... }:
{
	service = {
		xserver.enable = true;
		xserver.excludePackages = with pkgs; [
			xterm
		];

		# Display managers
		displayManager = {
			sddm = lib.mkIf (currentSystemDe == "plasma") {
				enable = true;
				wayland.enable = true; 
			};
			gdm.enable = lib.mkIf (currentSystemDe == "gnome") true;
		};

		# Desktop environments
		desktopManager = {
			plasma6.enable = lib.mkIf (currentSystemDe == "plasma") true;
			gnome.enable = lib.mkIf (currentSystemDe == "gnome") true;
		};
	};
	environment.plasma6.excludePackages = with pkgs.kdePackages; [
		elisa
		konsole
	];
	environment.gnome.excludePackages = with pkgs; [
		gnome-contacts
		gnome-console
		gnome-tour
		gnome-characters
		gnome-maps
		gnome-software
		xterm
		epiphany
		gedit
		simple-scan
		yelp
		geary
		seahorse
	];

	xdg = {
		autostart.enable = true;
		portal.enable = true;
	};

	programs.kdeconnect = lib.mkIf (currentSystemDe != "none") {
	  enable = true;
	  # FIXME: Make this work for KDE 
	  package = pkgs.gnomeExtensions.gsconnect;
	};
}
