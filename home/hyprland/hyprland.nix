{ currentSystemUser, ... }:
{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, Return, exec, kitty"
        "$mod, SPACE, exec, wofi --show run"
        "$mod SHIFT, L, exec, hyprlock"

        "$mod SHIFT, Q, killactive"
        "$mod, F, fullscreen"
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"
        "$mod SHIFT, right, resizeactive, 30 0"
        "$mod SHIFT, left, resizeactive, -30 0"
        "$mod SHIFT, up, resizeactive, 0 -30"
        "$mod SHIFT, down, resizeactive, 0 30"
        "$mod SHIFT, U, togglefloating"

        ",XF86MonBrightnessDown, exec, brightnessctl set 2%-"
        ",XF86MonBrightnessUp, exec, brightnessctl set +2%"
        ",XF86AudioLowerVolume, exec, pamixer -d 2"
        ",XF86AudioRaiseVolume, exec, pamixer -i 2"

        "$mod, delete, exit"
      ]
      ++ (builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        ) 9
      ));
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      monitor = ", preferred, auto, 1";

      input = {
        touchpad = {
          natural_scroll = "yes";
        };

        sensitivity = "0";
        accel_profile = "flat";
      };

      exec-once = [
        "waybar"
        "hyprpaper"
      ];

      exec = [
      ];
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "/home/${currentSystemUser}/Pictures/wallpaper.jpg" ];
      wallpaper = [ ",/home/${currentSystemUser}/Pictures/wallpaper.jpg" ];
    };
  };
}
