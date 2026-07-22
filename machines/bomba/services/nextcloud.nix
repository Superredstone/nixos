{
  pkgs,
  config,
  currentSystemUser,
  ...
}:
{
  services = {
    nextcloud = {
      enable = true;
      package = pkgs.nextcloud34;
      hostName = "nextcloud.patrickcanal.it";
      https = false;
      config = {
        adminpassFile = config.sops.secrets.nextcloud_password.path;
        dbtype = "sqlite";
        adminuser = currentSystemUser;
      };
      settings = {
        default_phone_region = "IT";
        overwriteprotocol = "https";
        mail_domain = "patrickcanal.it";
        log_type = "file";
        trusted_domains = [
          "nextcloud.patrickcanal.it"
        ];
      };
    };
    # Required to change nextcloud port
    nginx.virtualHosts."${config.services.nextcloud.hostName}".listen = [
      {
        addr = "127.0.0.1";
        port = 8004;
      }
    ];
  };
}
