{ ... }:
{
  sops.secrets = {
    nextcloud_password.sopsFile = ../../secrets/bomba.sops.yaml;
  };
}
