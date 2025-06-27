{ config, pkgs, ... }:

{
  # Activation du service SSH client
  programs.ssh = {
    startAgent = true;
    extraConfig = ''
      Host github.com
        HostName github.com
        User git
        IdentityFile ~/.ssh/id_ed25519
        IdentitiesOnly yes

      Host *
        ServerAliveInterval 60
        ServerAliveCountMax 3
        ControlMaster auto
        ControlPath ~/.ssh/sockets/%r@%h:%p
        ControlPersist 600
        PasswordAuthentication no
        PubkeyAuthentication yes
    '';
  };

  # Installation d'OpenSSH
  environment.systemPackages = with pkgs; [
    openssh
  ];
}
