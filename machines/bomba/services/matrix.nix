{ ... }:
{
  services.matrix-conduit = {
    enable = true;
    settings.global = {
      server_name = "patrickcanal.it";
      address = "127.0.0.1";
      allow_registration = true;
      trusted_servers = [ ];
    };
  };
}
