{
  pkgs,
  config,
  options,
  currentSystemEmail,
  ...
}:
{
  services.maddy = {
    enable = true;
    primaryDomain = "patrickcanal.it";
    ensureAccounts = [
      "postmaster@patrickcanal.it"
      "test@patrickcanal.it"
    ];
    ensureCredentials = {
      "postmaster@patrickcanal.it".passwordFile = "${pkgs.writeText "postmaster" "test"}";
      "test@patrickcanal.it".passwordFile = "${pkgs.writeText "test" "test"}";
    };
    tls = {
      loader = "file";
      certificates = [
        {
          keyPath = "/etc/ssl/certs/privkey.pem";
          certPath = "/etc/ssl/certs/fullchain.pem";
        }
      ];
    };
    config =
      builtins.replaceStrings
        [
          "imap tcp://0.0.0.0:143"
          "submission tcp://0.0.0.0:587"
        ]
        [
          "imap tls://0.0.0.0:993 tcp://0.0.0.0:143"
          "submission tls://0.0.0.0:465 tcp://0.0.0.0:587"
        ]
        options.services.maddy.config.default;
  };
}
