{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Superredstone";
        email = "patrickcanal3@gmail.com";
        signingkey = "1333CB9131084239";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      commit.gpgsign = true;
    };
  };
}
