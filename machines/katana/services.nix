{ pkgs, ... }:
{
	services.flatpak.enable = true;
	services.xserver.videoDrivers = ["nvidia"];

	services.xserver.enable = true;
	services.displayManager.sddm.enable = true;
	services.desktopManager.plasma6.enable = true;
	services.displayManager.sddm.wayland.enable = true; 

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
