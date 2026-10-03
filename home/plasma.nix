{ ... }:
{
  programs.alacritty = {
    enable = true;
    theme = "catppuccin_mocha";
    settings = {
      font = {
        normal = {
          family = "JetBrainsMono NerdFont";
          style = "medium";
        };
      };
    };
  };
}
