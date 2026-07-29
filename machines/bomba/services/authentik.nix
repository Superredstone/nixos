{ config, ... }:
{
  services.authentik = {
    enable = true;
    environmentFile = config.sops.secrets.authentik_env.path;
    settings = {
      disable_startup_analytics = true;
      avatars = "initials";
    };
  };
}
