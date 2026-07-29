{ config, ... }:
{
  services.vikunja = {
    enable = true;
    port = 8011;
    frontendScheme = "http";
    frontendHostname = "vikunja.patrickcanal.it";
    environmentFiles = [
      config.sops.secrets.vikunja_env.path
    ];
  };
}
