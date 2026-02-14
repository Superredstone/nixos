{ ... }:
{
  programs.vesktop = {
    enable = false;

    settings = {
      arRPC = true;
      hardwareAcceleration = true;
    };

    vencord.settings = {
      autoUpdate = true;
      autoUpdateNotification = true;
      notifyAboutUpdate = true;

      plugins = {
        CallTimer.enable = true;
        FakeNitro.enable = true;
      };
    };
  };
}
