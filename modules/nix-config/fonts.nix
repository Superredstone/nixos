{ pkgs, config, ... }:
{
  system.fsPackages = [ pkgs.bindfs ];
  fileSystems =
    let
      mkRoSymBind = path: {
        device = path;
        fsType = "fuse.bindfs";
        options = [
          "ro"
          "resolve-symlinks"
          "x-gvfs-hide"
        ];
      };
      fontsPkgs =
        config.fonts.packages
        ++ (with pkgs; [
          bibata-cursors
        ]);
      x11Fonts =
        pkgs.runCommand "X11-fonts"
          {
            preferLocalBuild = true;
            nativeBuildInputs = with pkgs; [
              gzip
              mkfontscale
              mkfontdir
            ];
          }
          (
            ''
              mkdir -p "$out/share/fonts"
              font_regexp='.*\.\(ttf\|ttc\|otb\|otf\|pcf\|pfa\|pfb\|bdf\)\(\.gz\)?'
            ''
            + (builtins.concatStringsSep "\n" (
              builtins.map (pkg: ''
                find ${toString pkg} -regex "$font_regexp" \
                  -exec ln -sf -t "$out/share/fonts" '{}' \;
              '') fontsPkgs
            ))
            + ''
              cd "$out/share/fonts"
              mkfontscale
              mkfontdir
              cat $(find ${pkgs.fontalias}/ -name fonts.alias) >fonts.alias
            ''
          );
      aggregatedIcons = pkgs.buildEnv {
        name = "system-icons";
        paths = fontsPkgs;
        pathsToLink = [
          "/share/icons"
        ];
      };
    in
    {
      "/usr/share/icons" = mkRoSymBind (aggregatedIcons + "/share/icons");
      "/usr/share/fonts" = mkRoSymBind (x11Fonts + "/share/fonts");
    };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
  ];
}
