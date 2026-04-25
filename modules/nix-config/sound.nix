{ ... }:
{
  # Enable sound with pipewire.
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    pulseaudio.enable = false;
  };
  security.rtkit.enable = true;
}
