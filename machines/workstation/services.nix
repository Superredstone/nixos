{ ... }:
{
  services = {
    flatpak.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "no";
      };
    };
  };
}
