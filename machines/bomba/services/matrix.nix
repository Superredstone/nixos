{ ... }:
{
  services.matrix-synapse = {
    enable = true;
    settings = {
      server_name = "patrickcanal.it";
      public_baseurl = "https://matrix.patrickcanal.it";
      enable_registration = true;
      enable_registration_without_verification = true;
      listeners = [
        {
          port = 8020;
          bind_addresses = [ "127.0.0.1" ];
          type = "http";
          tls = false;
          x_forwarded = true;
          resources = [
            {
              names = [
                "client"
                "federation"
              ];
              compress = false;
            }
          ];
        }
      ];
      database = {
        name = "psycopg2";
        args = {
          database = "matrix-synapse";
          user = "matrix-synapse";
        };
      };
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "matrix-synapse" ];
    ensureUsers = [
      {
        name = "matrix-synapse";
        ensureDBOwnership = true;
      }
    ];
  };
}
