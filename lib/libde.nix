{ currentSystemDe, lib, ... }:
let
  ifDesktop = de: content: {
    _type = "if";
    condition = currentSystemDe == de;
    inherit content;
  };
  ifNotDesktop = de: content: {
    _type = "if";
    condition = currentSystemDe != de;
    inherit content;
  };
  ifGnome = ifDesktop "gnome";
  ifPlasma = ifDesktop "plasma";
  ifNone = ifDesktop "none";
  ifNotNone = ifNotDesktop "none";
in
{
  inherit
    ifDesktop
    ifNotDesktop
    ifGnome
    ifPlasma
    ifNone
    ifNotNone
    ;
}
