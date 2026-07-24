{ config, ... }:
{
  services.vaultwarden = {
    enable = true;
    environmentFile = config.sops.secrets.vaultwarden_env.path;
    # config = {
    #   DOMAIN = "https://vaultwarden.patrickcanal.it";
    #   ROCKET_ADDRESS = "127.0.0.1";
    #   ROCKET_PORT = 8003;
    #   SSO_ENABLED = true;
    #   SSO_ONLY = false;
    #   SSO_AUTHORITY = "https://auth.patrickcanal.it";
    #   SSO_SCOPES = [
    #     "profile"
    #     "email"
    #     "offline_access"
    #     "vaultwarden"
    #   ];
    #   SSO_PKCE = true;
    #   SSO_CLIENT_ID = "vaultwarden";
    #   SSO_CLIENT_SECRET = config.sops.secrets.vaultwarden_sso_secret;
    #   SSO_ROLES_ENABLED = true;
    #   SSO_ROLES_DEFAULT_TO_USER = true;
    # };
  };
}
