{ pkgs, lib, currentSystemDe, ... }:
{
	services.xserver.enable = true;
	services.xserver.excludePackages = with pkgs; [
		xterm
	];

	# Display managers
	services.displayManager.sddm = lib.mkIf (currentSystemDe == "plasma") {
		enable = true;
		wayland.enable = true; 
	};
	services.displayManager.gdm.enable = lib.mkIf (currentSystemDe == "gnome") true;

	# Desktop environments
	services.desktopManager.plasma6.enable = lib.mkIf (currentSystemDe == "plasma") true;
	environment.plasma6.excludePackages = with pkgs.kdePackages; [
		elisa
		konsole
	];
	services.desktopManager.gnome.enable = lib.mkIf (currentSystemDe == "gnome") true;
	environment.gnome.excludePackages = with pkgs; [
		gnome-contacts
		gnome-console
		gnome-calculator
		gnome-tour
		gnome-characters
		gnome-maps
		gnome-clocks
		# gnome-software # Uncomment this once bazaar is available
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
		portal = {
			enable = true;
			extraPortals = with pkgs; [
				# xdg-desktop-portal-gtk
			];
		};
	};
}
