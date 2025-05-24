{ pkgs, lib, currentSystemDe, ... }:
{
	services.xserver.enable = true;

	# Display managers
	services.displayManager.sddm = lib.mkIf (currentSystemDe == "plasma") {
		enable = true;
		wayland.enable = true; 
	};
	services.xserver.displayManager.gdm.enable = lib.mkIf (currentSystemDe == "gnome") true;

	# Desktop environments
	services.desktopManager.plasma6.enable = lib.mkIf (currentSystemDe == "plasma") true;
	environment.plasma6.excludePackages = with pkgs.kdePackages; [
		elisa
		konsole
	];
	services.xserver.desktopManager.gnome.enable = lib.mkIf (currentSystemDe == "gnome") true;
}
