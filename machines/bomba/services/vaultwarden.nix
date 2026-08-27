{ config, ... }:
{
  services.vaultwarden = {
    enable = true;
    environmentFile = config.sops.secrets.vaultwarden_env.path;
  };
}
