{ currentSystemUser, ... }:
{
	wayland.windowManager.hyprland = {
		enable = true;
		settings = {
			"$mod" = "SUPER";
			bind = [
				"$mod, Return, exec, kitty"
				"$mod, F, fullscreen"
				"$mod, SPACE, exec, wofi --show run"
				"$mod SHIFT, Q, killactive"
				"$mod SHIFT, L, exec, hyprlock"

				"$mod, H, movefocus, l"
				"$mod, L, movefocus, r"
				"$mod, K, movefocus, u"
				"$mod, J, movefocus, d"
				"$mod SHIFT, H, movewindow, l"
				"$mod SHIFT, L, movewindow, r"
				"$mod SHIFT, K, movewindow, u"
				"$mod SHIFT, J, movewindow, d"
			] ++ (
				builtins.concatLists (builtins.genList (i: 
					let ws = i + 1;
					in [
						"$mod, code:1${toString i}, workspace, ${toString ws}"
						"$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
					]
					) 
				9)
			);
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
			};

			exec-once = [
				"waybar"
				"hyprpaper"
			];
		};
	};

	services.hyprpaper = {
		enable = true;
		settings = {
			preload = ["/home/${currentSystemUser}/Pictures/wallpaper.jpg"];
			wallpaper = [",/home/${currentSystemUser}/Pictures/wallpaper.jpg"];
		};
	};
}
