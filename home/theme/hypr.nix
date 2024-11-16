{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;

    xwayland = {
      enable = true;
    };

    systemd.enable = true;

    settings = {
      "$mainMod" = "SUPER";

      exec-once = [
        "swaybg -i /home/ionut/Pictures/Wallpaper/wallhaven-howl.jpg &"
        "hyprpaper"
        "waybar &"
        "blueman-applet"
        "nm-applet --indicator &"
        "hyprctl setcursor Bibata-Modern-Ice 22"
        "hypridle"
        #        "udiskie &"
        "asusctl profile -P Quiet &"
        "[workspace 1 silent] firefox"
        "[workspace 2 silent]kitty tmux #alacritty"
      ];

      monitor = [
        ",highres,auto,1"
      ];

      env = [
        "Bibata-Modern-Ice,~/.icons/Bibata-modern-ice"
        "QT_QPA_PLATFORM,wayland"
        "HYPRCURSOR_THEME,Bibata-Modern-Ice"
        "HYPRCURSOR_SIZE,22"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
        # Nvidia

        "LIBVA_DRIVER_NAME,nvidia"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "__GL_VRR_ALLOWED,1"
        "WLR_NO_HARDWARE_CURSORS,1"
        "WLR_DRM_NO_ATOMIC,1"
      ];

      general = {
        gaps_in = 0;
        gaps_out = 0;

        border_size = 2;

        border_part_of_window = true;

        layout = "master";

        allow_tearing = false;
      };

      decoration = {
        rounding = 0;

        drop_shadow = "no";

        shadow_range = 4;
        shadow_render_power = 3;
        blur = {
          enabled = true;
          size = 2;
          passes = 3;
        };
      };

      master = {
        new_status = true;
        allow_small_split = true;
        mfact = 0.6;
        orientation = "left";
      };

      gestures = {workspace_swipe = true;};

      misc = {
        force_default_wallpaper = 0;
      };

      device = {
        name = "epic-mouse-v1";
        sensitivity = "-0.5";
      };

      animations = {
        enabled = true;

        bezier = "myBezier, 0.10, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 5, myBezier, slide"
          "windowsOut, 1, 5, myBezier, slide"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      input = {
        kb_layout = "us";

        kb_options = "caps:escape";
        follow_mouse = 1;
        sensitivity = 0;

        touchpad = {
          natural_scroll = false;
        };
      };
      bind = [
        "ALT, Tab, cyclenext,"
        "$mainMod, Q, exec, kitty #alacritty"
        "$mainMod SHIFT, Q, exec, kitty tmux #alacritty"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, thunar"
        "$mainMod, F, togglefloating,"
        "$mainMod, S, exec, wofi --normal-window --term alacritty --show drun"
        "$mainMod, T, pseudo, # dwindle"
        "$mainMod, J, togglesplit, # dwindle"
        "$mainMod, S, exec, magic"
        "$mainMod SHIFT, S, exec, grim -g \"$(slurp -w 0)\" - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png | dunstify \"Screenshot of the region taken\" -t 1000"
        ", Print, exec, grim - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png | dunstify \"Screenshot of whole screen taken\" -t 1000 # screenshot of the whole screen"
        "$mainMod, p , exec, hyprlock"
        "$mainMod, h, movefocus, l"
        "$mainMod, j, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, l, movefocus, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];
      binde = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-"

        ",XF86MonBrightnessUp, exec, brightnessctl set +10%"
        ",XF86MonBrightnessDown, exec, brightnessctl set 10%-"
      ];
      bindm = [
        " $mainMod, mouse:272, movewindow"
        " $mainMod, mouse:273, resizewindow"
      ];
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];
    };
  };
}
