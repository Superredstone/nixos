{ currentSystemEmail, ... }:
{
  services.nginx = {
    enable = false;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    virtualHosts =
      let
        base = locations: {
          inherit locations;

          enableACME = true;
          forceSSL = true;
        };
        proxy =
          ipPort:
          base {
            "/".proxyPass = "http://" + ipPort + "/";
          };
      in
      {
        "patrickcanal.it" = {
          root = "/var/www/patrickcanal.it/public/";
          enableACME = true;
          forceSSL = true;
        };
        "gitea.patrickcanal.it" = proxy "127.0.0.1:8001" // {
          default = true;
        };
        "vaultwarden.patrickcanal.it" = proxy "172.18.0.2:8002" // {
          default = true;
        };
      };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = currentSystemEmail;
  };
}
