{ config, pkgs, ... }:

{
  imports = [ <home-manager/nixos> ./vim.nix ./i3.nix ];


  home-manager.users.mainUser = {

    nixpkgs.config.allowUnfree = true;
    home.stateVersion = "23.05";

    fonts.fontconfig.enable = true;
    home.packages = [
      pkgs.openssh
      pkgs.htop
      pkgs.taskell
      (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })

      #formatters
      pkgs.treefmt
      pkgs.nixpkgs-fmt
      pkgs.shfmt
      pkgs.shellcheck
      pkgs.black

      # software
      pkgs.element-desktop
      pkgs.zsh-powerlevel10k
      pkgs.jetbrains.pycharm-community
    ];

    programs.vscode.enable = true;
    programs.zsh = {
      enable = true;
      shellAliases.cat = "${pkgs.bat}/bin/bat";
      shellAliases.ls = "ls -la";
      shellAliases.cdn = "cd /etc/nixos";
      shellAliases."gitit" = "git add . && git commit";
      oh-my-zsh = {
        enable = true;
        custom = "$HOME/.zsh_custom";
        plugins = [ "git" ];
        theme = "powerlevel10k/powerlevel10k";
      };
    };
    home.file.".zsh_custom/themes/powerlevel9k".source =
      pkgs.fetchFromGitHub {
        owner = "bhilburn";
        repo = "powerlevel9k";
        rev = "v0.6.4";
        sha256 = "104wvlni3rilpw9v1dk848lnw8cm8qxl64xs70j04ly4s959dyb5";
      };
    home.file.".zsh_custom/themes/powerlevel10k".source =
      pkgs.fetchFromGitHub {
        owner = "romkatv";
        repo = "powerlevel10k";
        rev = "v1.18.0";
        sha256 = "IiMYGefF+p4bUueO/9/mJ4mHMyJYiq+67GgNdGJ6Eew=";
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
  fonts.fonts = with pkgs; [ powerline-fonts ];
}

