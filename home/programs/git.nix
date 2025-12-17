{ config, pkgs, settings, ... }:

{
  programs.git.settings = {
    enable = true;
    userName = settings.user.fullName;
    userEmail = settings.user.email;

    extraConfig = {
      core.editor = "neovim";
      init.defaultBranch = "main";
      pull.rebase = false;
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
    };

    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      ci = "commit";
      unstage = "reset HEAD --";
      last = "log -1 HEAD";

      df = "!git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME";
    };
  };
}
