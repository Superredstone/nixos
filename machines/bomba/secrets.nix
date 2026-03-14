{ config, ... }:
{
  sops = {
    secrets = {
      nextcloud_password = {
        owner = "nextcloud";
        sopsFile = ../../secrets/bomba.sops.yaml;
      };
      ntfy_users = {
        owner = "ntfy-sh";
        sopsFile = ../../secrets/bomba.sops.yaml;
      };
      ntfy_access = {
        owner = "ntfy-sh";
        sopsFile = ../../secrets/bomba.sops.yaml;
      };
    };
    templates."ntfy.env".content = ''
      NTFY_AUTH_USERS='${config.sops.placeholder.ntfy_users}'
      NTFY_AUTH_ACCESS='${config.sops.placeholder.ntfy_access}'
    '';
  };
}
