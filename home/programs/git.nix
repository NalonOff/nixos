{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Nalon";
    userEmail = "nalonoff@gmail.com";
    
    extraConfig = {
      core.editor = "vim";
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
