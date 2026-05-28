{ config, ... }:
{
  config.services.gitea = {
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

  config.virtualisation.oci-containers.containers.gitea-act-runner = {
    image = "docker.io/gitea/act_runner:latest";
    environmentFiles = [
      config.sops.templates."gitea_runner.env".path
    ];
    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock"
    ];
  };
}
