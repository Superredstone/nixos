{ ... }:
{
  services.gitea = {
    enable = true;
    settings = {
      server = {
        DOMAIN = "gitea.patrickcanal.it";
        ROOT_URL = "https://gitea.patrickcanal.it";
        HTTP_PORT = 8001;
      };
      service.DISABLE_REGISTRATION = true;
    };
  };
}
