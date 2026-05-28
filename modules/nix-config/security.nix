{ currentSystemUser, ... }:
let
  swBin = "/run/current-system/sw/bin";
  wrappersBin = "/run/wrappers/bin";
in
{
  security.sudo = {
    extraConfig = ''
      Defaults pwfeedback
      Defaults timestamp_timeout=120
    '';
    extraRules = [
      {
        groups = [ "wheel" ];
        commands = [
          {
            command = "${swBin}/shutdown";
            options = [ "NOPASSWD" ];
          }
          {
            command = "${swBin}/reboot";
            options = [ "NOPASSWD" ];
          }
          {
            command = "${swBin}/poweroff";
            options = [ "NOPASSWD" ];
          }
          {
            command = "${wrappersBin}/mount";
            options = [ "NOPASSWD" ];
          }
          {
            command = "${wrappersBin}/umount";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
  sops = {
    age.sshKeyPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
    ];
    defaultSopsFile = ../../secrets/default.sops.yaml;
    secrets = {
      "wifi_password" = {
        owner = currentSystemUser;
      };
      "user_password" = {
        neededForUsers = true;
      };
    };
  };
}
