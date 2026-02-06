{ ... }:
{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        height = 30;
        spacing = 1;
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "tray"
          "pulseaudio"
          "network"
          "power-profiles-daemon"
          "backlight"
          "battery"
          "clock"
        ];

        "hyprland/workspaces" = {
          format = "{name} {icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
          };
        };
        "tray" = {
          spacing = 10;
        };
        "pulseaudio" = {
          format = "{volume}% {icon}";
          format-icons = {
            headphones = "";
            bluetooth = "󰥰";
            handsfree = "";
            headset = "󱡬";
            phone = "";
            portable = "";
            car = "";
            default = [
              "🕨"
              "🕩"
              "🕪"
            ];
          };
          on-click = "pavucontrol";
        };
        "hyprland/window" = {
          format = "{class}";
        };
        "battery" = {
          "interval" = 1;
          states = {
            good = 80;
            warning = 30;
            critical = 20;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% 󰂄";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = [
            "󰁻"
            "󰁼"
            "󰁾"
            "󰂀"
            "󰂂"
            "󰁹"
          ];
        };
        # Currently not enabled because i don't want to add some external tools to manage brightness
        # backlight = {
        # 	format = "{percent}% {icon}";
        # 	format-icons = [
        # 		""
        # 		""
        # 		""
        # 		""
        # 		""
        # 		""
        # 		""
        # 		""
        # 		""
        # 		""
        # 	];
        #   	on-scroll-down = "light -A 10";
        # 			on-scroll-up = "light -U 10";
        # 			smooth-scrolling-threshold = 1;
        # };
        "network" = {
          format-wifi = "{ipaddr} Wi-Fi";
          format-ethernet = "{ipaddr} Eth";
        };
        "power-profiles-daemon" = {
          "format" = "{icon}";
          "tooltip-format" = "Power profile: {profile}\nDriver: {driver}";
          "tooltip" = true;
          "format-icons" = {
            "default" = "";
            "performance" = "";
            "balanced" = "";
            "power-saver" = "";
          };
        };
      };
    };

    style = ''
      @define-color rosewater #f5e0dc;
      @define-color flamingo #f2cdcd;
      @define-color pink #f5c2e7;
      @define-color mauve #cba6f7;
      @define-color red #f38ba8;
      @define-color maroon #eba0ac;
      @define-color peach #fab387;
      @define-color yellow #f9e2af;
      @define-color green #a6e3a1;
      @define-color teal #94e2d5;
      @define-color sky #89dceb;
      @define-color sapphire #74c7ec;
      @define-color blue #89b4fa;
      @define-color lavender #b4befe;
      @define-color text #cdd6f4;
      @define-color subtext1 #bac2de;
      @define-color subtext0 #a6adc8;
      @define-color overlay2 #9399b2;
      @define-color overlay1 #7f849c;
      @define-color overlay0 #6c7086;
      @define-color surface2 #585b70;
      @define-color surface1 #45475a;
      @define-color surface0 #313244;
      @define-color base #1e1e2e;
      @define-color mantle #181825;
      @define-color crust #11111b;

      * {
          border: none;
          border-radius: 1px;
          font-family: JetBrainsMono Nerd Font;
          font-size: 13px;
          min-height: 0;
      }

      window#waybar {
          background-color: @mantle;
          color: @text;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      tooltip {
          background-color: @base;
          border: 1px solid @surface1;
      }

      tooltip label {
          color: @text;
      }

      button {
          box-shadow: inset 0 -3px transparent;
          border: none;
          border-radius: 1px;
      }

      button:hover {
          background: inherit;
          box-shadow: inset 0 -3px @text;
      }

      #workspaces button {
          padding: 0 0;
          background-color: @mantle;
          color: @text;
      }

      #workspaces button:hover {
          box-shadow: inherit;
          text-shadow: inherit;
          background-image: linear-gradient(0deg, @surface1, @mantle);
      }

      #workspaces button.focused {
          background-image: linear-gradient(0deg, @mauve, @surface1);
          box-shadow: inset 0 -3px @text;
      }

      #workspaces button.urgent {
          background-image: linear-gradient(0deg, @red, @mantle);
      }

      #taskbar button.active {
          background-image: linear-gradient(0deg, @surface1, @mantle);
      }

      #mode {
          background-color: @base;
          box-shadow: inset 0 -2px @text;
      }

      #mpris,
      #custom-weather,
      #clock,
      #language,
      #pulseaudio,
      #bluetooth,
      #network,
      #memory,
      #cpu,
      #temperature,
      #disk,
      #custom-kernel,
      #idle_inhibitor,
      #scratchpad,
      #mode,
      #power-profiles-daemon,
      #backlight,
      #battery,
      #tray {
          padding: 0 10px;
          margin: 5px 1px;
          color: @text;
      }

      #window,
      #workspaces {
          margin: 0 4px;
      }

      #power-profiles-daemon {
      	background-color: @red;
      	color: @base;
      }

      #custom-weather {
          background-color: @teal;
          color: @mantle;
          margin-right: 5px;
      }

      #custom-kernel {
          background-color: @rosewater;
          color: @mantle;
      }

      #clock {
          background-color: @green;
          color: @mantle;
      }

      @keyframes blink {
          to {
              background-color: @mantle;
              color: @text;
          }
      }

      label:focus {
          background-color: @mantle;
      }

      #cpu {
          background-color: @mauve;
          color: @mantle;
          min-width: 45px;
      }

      #memory {
          background-color: @red;
          color: @mantle;
      }

      #disk {
          background-color: @flamingo;
          color: @mantle;
      }

      #battery {
      	background-color: @mauve;
      	color: @base;
      }

      #backlight {
      	background-color: @sky;
      	color: @base;
      }

      #network {
          background-color: @peach;
          color: @mantle;
      }

      #network.disconnected {
          background-color: red;
          color: @mantle;
      }

      #bluetooth {
          background-color: @maroon;
          color: @mantle;
          min-width: 40px;
      }

      #pulseaudio {
          background-color: @yellow;
          color: @mantle;
      }

      #pulseaudio.muted {
          background-color: red;
          color: @mantle;
      }

      #temperature {
          background-color: @pink;
          color: @mantle;
          min-width: 37px;
      }

      #temperature.critical {
          background-color: red;
          color: @mantle;
          min-width: 37px;
      }

      #mpris {
          background-color: @base;
          color: @text;
      }

      #tray {
          background-color: @overlay0;
          color: @text;
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: @mantle;
      }

      #idle_inhibitor {
          background-color: @base;
          color: @text;
          font-family: Inter;
      }

      #idle_inhibitor.activated {
          background-color: @text;
          color: @base;
      }

      #scratchpad {
          background-color: @base;
          color: @text;
      }

      #scratchpad.empty {
          background-color: transparent;
      }
      		'';
  };
}
