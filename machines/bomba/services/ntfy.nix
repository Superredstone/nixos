{ config, ... }:
{
  # services.ntfy-sh = {
  #   enable = false;
  #   environmentFile = config.sops.templates."ntfy.env".path;
  #   settings = {
  #     listen-http = ":8005";
  #     base-url = "https://ntfy.patrickcanal.it";
  #     smtp-server-listen = ":25";
  #     smtp-server-domain = "patrickcanal.it";
  #     behind-proxy = true;
  #     enable-login = true;
  #     require-login = true;
  #   };
  # };
}
