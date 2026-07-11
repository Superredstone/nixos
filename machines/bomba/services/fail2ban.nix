{ ... }:
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
  };
}
