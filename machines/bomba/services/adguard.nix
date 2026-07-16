{ ... }:
{
  services.adguardhome = {
    enable = true;
    port = 8017;
    mutableSettings = true;
    settings = {
      dns = {
        upstream_dns = [
          "1.1.1.1"
          "9.9.9.9"
        ];
        bind_hosts = [ "192.168.1.223" ];
        port = 53;
      };
    };
  };
}
