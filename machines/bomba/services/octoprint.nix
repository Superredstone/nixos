{ pkgs-my-features, ... }:
{
  services.octoprint = {
    enable = true;
    port = 8002;
    package = pkgs-my-features.octoprint;
    plugins =
      plugins: with plugins; [
        fanspeedslider
      ];
  };
}
