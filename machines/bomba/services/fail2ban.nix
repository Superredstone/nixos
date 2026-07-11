{ lib, ... }:
{
  services.fail2ban = {
    enable = true;
    ignoreIP = [ "192.168.1.0/24" ];
    bantime = "4h";
    bantime-increment = {
      enable = true; 
      multipliers = "1 2 4 8 16 32 64";
      overalljails = true;
    };
    jails = {
      caddy-filter.settings = {
        enabled = true;
        port = "http,https";
	action = "iptables-multiport";
        filter = "caddy-filter";
        logpath = "/var/log/caddy/*.log";
        maxretry = 8;
	backend = "auto";
      };
    };
  };

  environment.etc = {
    "fail2ban/filter.d/caddy-filter.local".text = lib.mkDefault (
      lib.mkAfter ''
        [Definition]
        failregex = ^\{"level":"info","ts":\d+\.\d+,"logger":"http\.log\.access\.log\d*","msg":"handled request".*"remote_ip":"<HOST>".*"status":4\d{2}.*
        ignoreregex =
      ''
    );
  };
}
