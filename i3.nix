{ config, lib, pkgs, ... }:

let
  cfg = config.home-manager.users.mainUser.xsession.windowManager.i3;
  colorTheme =
    let
      theme = (import ./colorThemes.nix).solarized.light.hex;
    in
    theme // {
      foreground = theme.base3;
      background = theme.base03;
    };

in
{

  services.xserver = {
    enable = true;
    displayManager = {
      lightdm.enable = true;
      autoLogin = {
        enable = true;
        user = "mainUser";
      };
      defaultSession = "none+i3";
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
      ];
    };
    # keymap in X11
    layout = "us";
    xkbVariant = "";
    xkbOptions = "caps:swapescape";
  };
  home-manager.users.mainUser = {

    programs.i3status = {
      enable = true;
      modules = {
      };
    };
    programs.kitty = {
      enable = true;
      theme = "Gruvbox Light Hard";
      settings = {
        font_family = "JetBrains Mono";
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";
        font_size = 8;
      };
    };

    programs.alacritty = {
      enable = true;
      settings = {
        import =
          let
            themes = pkgs.fetchFromGitHub {
              owner = "alacritty";
              repo = "alacritty-theme";
              rev = "024c5c0dfb65197d5796e29e307b321af9a5e198";
              sha256 = "sha256-zXyGXZSmmTup5o7Dx6he+57vSFpygR+GSD+3PTxDbVk=";
            };
          in
          [ "${themes}/themes/gruvbox_light.yaml" ];
        font = {
          normal = {
            family = "Courier New";
            style = "Regular";
          };
          bold = {
            family = "Courier New";
            style = "Bold";
          };
          italic = {
            family = "Courier New";
            style = "Italic";
          };
          size = 8.0;
        };
      };
    };


    xsession.windowManager.i3 = {
      enable = true;
      extraConfig = ''
        default_border pixel 

        # workspace config
        set $terms "1: terms"
        set $web "2: web"
        set $com "3: com"
        workspace_auto_back_and_forth yes

        # apps and workspaces
        assign [class="firefox" instance="Navigator"] $web
        assign [class="Element"] $com

        # power and login menu
        set $mode_system System (l) lock, (e) logout, (s) suspend, (h) hibernate, (r) reboot, (CTRL+s) shutdown
        mode "$mode_system" {
        #  bindsym l exec --no-startup-id $i3lockwall, mode "default"
          bindsym e exec --no-startup-id i3-msg exit, mode "default"
        #  bindsym s exec --no-startup-id $i3lockwall && systemctl suspend, mode "default"
        #  bindsym h exec --no-startup-id $i3lockwall && systemctl hibernate, mode "default"
          bindsym r exec --no-startup-id systemctl reboot, mode "default"
          bindsym Ctrl+s exec --no-startup-id systemctl poweroff -i, mode "default"
          bindsym Return mode "default"
          bindsym Escape mode "default"
        }
        bindsym ${cfg.config.modifier}+BackSpace mode "$mode_system"

      '';
      config = {
        modifier = "Mod4";
        terminal = "alacritty";
        fonts = {
          names = [ "JetBrains Mono" ];
          size = 8.0;
        };
        keybindings = {
          "${cfg.config.modifier}+Return" = "exec ${cfg.config.terminal}";
          "${cfg.config.modifier}+Shift+q" = "exit";
          "${cfg.config.modifier}+q" = "kill";
          "${cfg.config.modifier}+d" = "exec --no-startup-id dmenu_run";

          "${cfg.config.modifier}+h" = "focus left";
          "${cfg.config.modifier}+j" = "focus down";
          "${cfg.config.modifier}+k" = "focus up";
          "${cfg.config.modifier}+l" = "focus right";

          "${cfg.config.modifier}+Shift+h" = "move left";
          "${cfg.config.modifier}+Shift+j" = "move down";
          "${cfg.config.modifier}+Shift+k" = "move up";
          "${cfg.config.modifier}+Shift+l" = "move right";

          "${cfg.config.modifier}+c" = "split h";
          "${cfg.config.modifier}+v" = "split v";
          "${cfg.config.modifier}+f" = "fullscreen toggle";

          "${cfg.config.modifier}+s" = "layout stacking";
          "${cfg.config.modifier}+w" = "layout tabbed";
          "${cfg.config.modifier}+e" = "layout toggle split";

          "${cfg.config.modifier}+t" = "floating toggle";
          "${cfg.config.modifier}+space" = "focus mode_toggle";


          "${cfg.config.modifier}+p" = "focus parent";

          "${cfg.config.modifier}+Shift+minus" = "move scratchpad";
          "${cfg.config.modifier}+minus" = "scratchpad show";

          "${cfg.config.modifier}+1" = "workspace $terms";
          "${cfg.config.modifier}+2" = "workspace $web";
          "${cfg.config.modifier}+3" = "workspace $com";
          "${cfg.config.modifier}+4" = "workspace 4";
          "${cfg.config.modifier}+5" = "workspace 5";
          "${cfg.config.modifier}+6" = "workspace 6";
          "${cfg.config.modifier}+7" = "workspace 7";
          "${cfg.config.modifier}+8" = "workspace 8";
          "${cfg.config.modifier}+9" = "workspace 9";
          "${cfg.config.modifier}+0" = "workspace 10";

          "${cfg.config.modifier}+Shift+1" = "move container to workspace $terms";
          "${cfg.config.modifier}+Shift+2" = "move container to workspace $web";
          "${cfg.config.modifier}+Shift+3" = "move container to workspace $com";
          "${cfg.config.modifier}+Shift+4" = "move container to workspace number 4";
          "${cfg.config.modifier}+Shift+5" = "move container to workspace number 5";
          "${cfg.config.modifier}+Shift+6" = "move container to workspace number 6";
          "${cfg.config.modifier}+Shift+7" = "move container to workspace number 7";
          "${cfg.config.modifier}+Shift+8" = "move container to workspace number 8";
          "${cfg.config.modifier}+Shift+9" = "move container to workspace number 9";
          "${cfg.config.modifier}+Shift+0" = "move container to workspace number 10";

          "${cfg.config.modifier}+Escape" = "workspace back_and_forth";
        };
      };
    };
  };
}
