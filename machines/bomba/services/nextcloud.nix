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
      package = pkgs.nextcloud33;
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
        trusted_domains = [
          "nextcloud.patrickcanal.it"
        ];
      };
    };
    nginx.virtualHosts."${config.services.nextcloud.hostName}".listen = [
      {
        addr = "172.18.0.1";
        port = 8004;
      }
    ];
  };
}
