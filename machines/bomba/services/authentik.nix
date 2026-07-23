{ config, ... }:
{
  services.authentik = {
    enable = true;
    environmentFile = config.sops.secrets.authentik_env.path;
    settings = {
      disable_startup_analytics = true;
      avatars = "initials";
      listen = {
        ldap = "0.0.0.0:3389";
        ldaps = "0.0.0.0:6636";
      };
    };
  };
}
