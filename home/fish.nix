{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      			# This is commented until a good way of installing themes is found
      			# fish_config theme choose Catppuccin\ Mocha

      			function fish_greeting 
              # Check if not inside of a distrobox 
              if not test -n "$CONTAINER_ID" 
      				  krabby random --no-title --padding-left 2
              end
      			end
       
      			function weather
      				curl "wttr.in/Bolzano?0?Q?" 
      			end

      			function dev
      				nix develop --command "fish"
      			end
      		'';
    plugins = with pkgs.fishPlugins; [
      {
        name = "fzf.fish";
        src = fzf-fish.src;
      }
    ];
  };
}
