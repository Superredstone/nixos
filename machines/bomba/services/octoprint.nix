{ ... }:
{
  nixpkgs.overlays = [
    (self: super: {
      octoprint = super.octoprint.override {
        packageOverrides = pyself: pysuper: {
          octoprint-fanspeedslider = pyself.buildPythonPackage rec {
            pname = "fanspeedslider";
            version = "0.2.3";
            src = self.fetchFromGitHub {
              owner = "mival";
              repo = "OctoPrint-FanSpeedSlider";
              rev = "${version}";
              sha256 = "sha256-0Gp9EgaKyCnRQv4A1sNHquTRqjag2Oz/fDGVVo95FfY=";
            };
            propagatedBuildInputs = [ pysuper.octoprint ];
	    pyproject = true;
            doCheck = false;
          };
        };
      };
    })
  ];
  services.octoprint = {
    enable = true;
    port = 8002;
    plugins =
      plugins: with plugins; [
        octoprint-fanspeedslider
      ];
  };
}
