{ ... }:
{
  security.sudo.extraConfig = ''
    		Defaults pwfeedback
        		Defaults timestamp_timeout=120
    	'';
  sops = {
    age.sshKeyPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
    ];
    defaultSopsFile = ../../secrets/default.sops.yaml;
    secrets = {
      "wifi_password" = { };
    };
  };
}
