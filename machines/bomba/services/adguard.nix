{ ... }:
{
  services.adguardhome = {
    enable = true;
    mutableSettings = true;
    settings = {
      http.address = "0.0.0.0:8017";
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
