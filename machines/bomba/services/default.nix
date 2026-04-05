{ ... }:
{
  imports = [
    # ./nginx.nix
    ./gitea.nix
    ./nextcloud.nix
    ./ntfy.nix
    ./maddy.nix
    ./octoprint.nix
    ./vaultwarden.nix
  ];
  services.teamspeak3 = {
    enable = true;
    openFirewall = true;
  };

  services.openssh.enable = true;
}
