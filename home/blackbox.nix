{ pkgs, ... }:
let
  catppuccinTheme = pkgs.stdenv.mkDerivation {
    name = "catppuccin-theme";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "tilix";
      rev = "f29239686d1309b9eaaf03447156ae16427a3ef7";
      hash = "sha256-d/HOSQ4F06s2aMojS9lK8Vbx8AJXdlxuK88W9h9q0kw=";
    };
    installPhase = ''
      	cp themes/catppuccin-mocha.json $out
    '';
  };
in
{
  home.file."blackbox-catppuccin" = {
    source = catppuccinTheme;
    target = ".local/share/blackbox/schemes/catppuccin-mocha.json";
  };
}
