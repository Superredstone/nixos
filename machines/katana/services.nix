{ pkgs, lib, currentSystemDe, ... }:
{
	services.flatpak.enable = true;
	services.xserver.videoDrivers = ["nvidia"];

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

	# Enable sound with pipewire.
	services.pulseaudio.enable = false;
	security.rtkit.enable = true;

	# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

	# Enable CUPS to print documents.
	services.printing.enable = true;

	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};
}
