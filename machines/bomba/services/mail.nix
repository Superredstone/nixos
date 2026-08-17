{ config, ... }:
let
  fqdn = "mail.patrickcanal.it";
in
{
  security.acme = {
    acceptTerms = true;
    certs."mail.patrickcanal.it" = {
      webroot = "/var/www/patrickcanal.it/public/";
    };
  };

  mailserver = {
    enable = true;
    stateVersion = 5;
    fqdn = fqdn;
    domains = [ "patrickcanal.it" ];

    # Reference the existing ACME configuration created by nginx
    x509.useACMEHost = fqdn;

    # A list of all login accounts. To create the password hashes, use
    # nix-shell -p mkpasswd --run 'mkpasswd -s'
    accounts = {
      "me@patrickcanal.it" = {
        hashedPassword = "$y$j9T$zEKbsELY3HcPZq9CH6bSe0$T9syGTl9haNhjS5SNjDbrY5uoN5z/LCYEmbFowFcAP/";

        # Additional addresses delivered to this mailbox
        aliases = [
          "postmaster@patrickcanal.it"
          "io@patrickcanal.it"
        ];
      };
      "auth@patrickcanal.it" = {
        hashedPassword = "$y$j9T$JqqefR6flaaJBRjD4KVZc1$QM6h4Spr5.yn/FuIT.ydTV22daEbiVd8ZprV/POtPgB";
      };
    };
  };
}
