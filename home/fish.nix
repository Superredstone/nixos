{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      "please" = "sudo $history[1]";
      "amend" = "git commit --amend";
      "commit" = "git commit";
      "add" = "git add .";
      "ssh" = "kitten ssh";
      "dev" = "nix develop --command 'fish'";
    };
    interactiveShellInit = ''
      # This is commented until a good way of installing themes is found
      # fish_config theme choose Catppuccin\ Mocha

      function fish_greeting 
        # Check if not inside of a distrobox 
        if not test -n "$CONTAINER_ID" 
          krabby random --no-title --padding-left 2
        end
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
