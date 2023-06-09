{ config, pkgs, ... }:

{
  imports = [ <home-manager/nixos> ./vim.nix ./i3.nix ];


  home-manager.users.mainUser = {
    home.stateVersion = "23.05";

    home.packages = [
      pkgs.openssh
      pkgs.htop
      pkgs.taskell

      #formatters
      pkgs.treefmt
      pkgs.nixpkgs-fmt
      pkgs.shfmt
      pkgs.shellcheck
      pkgs.black

      # software
      pkgs.element-desktop
    ];

    programs.bash = {
      enable = true;
      shellAliases.cat = "${pkgs.bat}/bin/bat";
      shellAliases.ls = "ls -la";
      shellAliases.cdn = "cd /etc/nixos";
      shellAliases."gitit" = "git add . && git commit";
    };

    programs.mcfly = {
      enable = true;
      keyScheme = "vim";
      fuzzySearchFactor = 3;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };

    programs.bat = {
      enable = true;
      config.theme = "gruvbox-light";
    };

    programs.git = {
      enable = true;
      userName = "Adrian Bernhard";
      userEmail = "adrianbernhard@gmail.com";
      ignores = [ "*.swp" "*~" ".idea" ".*penis.*" "result" ];
      extraConfig = {
        init.defaultBranch = "main";
        pull.ff = "only";
      };
    };
    programs.ssh.enable = true;
    programs.ssh.matchBlocks = {
      "*" = {
        identityFile = "~/.ssh/trudix_ed25519";
        identitiesOnly = true;
      };
      "github" = {
        hostname = "github.com";
        user = "git";
      };
    };
  };
}
