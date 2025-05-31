{
  config,
  inputs,
  pkgs,
  pkgs-unstable,
  ...
}: {
  environment.systemPackages =
    (with pkgs; [
      #bluetooth and sound
      pipewire
      wireplumber
      alsa-lib
      pavucontrol
      pwvucontrol
      bluez-tools
      bluez
      libgtop
      dart-sass

      python3
      #Utils
      rar
      unzip
      zip
      brillo
      tree

      brightnessctl
      networkmanager
      networkmanagerapplet

      github-desktop
      lazygit
      git
      starship
      wl-clipboard
      peek
      grim
      slurp
      nsxiv
      zathura
      lf
      kitty
      trash-cli
      poppler

      tmux
      mpv
      lsd
      cmatrix
      cava
      lshw
      pandoc
      texliveTeTeX

      #obsidian
      obs-studio
      ffmpeg

      #utilities
      entr
      udiskie
      udisks
      ncdu
      btop

      discord
      signal-desktop
      unityhub

      neovim
      arduino-ide
      inkscape
      libreoffice

      firefox
      obsidian

      fastfetch

      lutris

      wine
      wine-wayland
      wineWowPackages.stable
      wineWowPackages.waylandFull

      bottles
      fragments
      alacritty

      prusa-slicer
      #Tiganie pt freecad
      (pkgs.symlinkJoin {
        name = "FreeCAD";
        paths = [pkgs.freecad-wayland];
        buildInputs = [pkgs.makeWrapper];
        postBuild = ''
          wrapProgram $out/bin/FreeCAD \
          --set __GLX_VENDOR_LIBRARY_NAME mesa \
          --set __EGL_VENDOR_LIBRARY_FILENAMES ${pkgs.mesa.drivers}/share/glvnd/egl_vendor.d/50_mesa.json
        '';
        meta.mainProgram = "FreeCAD";
      })

      wget
      gnome-clocks
      nautilus
      xfce.thunar
      xfce.tumbler
      gvfs

      #Dev
      marp-cli
      clang
      llvm
      gcc
      cmake
      gnumake
      fd
      bat
      #Blender stuf
      mesa
      libGL
      vulkan-loader

      #style formatter
      lua54Packages.luacheck
      lua54Packages.luarocks
      lua-language-server
      stylua
      eslint
      shellcheck

      #GTK
      gtk2
      gtk3
      gtk4
      glib
      #lxappearance-gtk2
      gnome-themes-extra
      adwaita-icon-theme
      gtk-engine-murrine
      gruvbox-gtk-theme
      gruvbox-dark-gtk

      #Hyprland rice
      qt5.qtwayland
      qt6.qtwayland
      pkgs.dunst
      waybar
      hyprpanel

      nwg-displays
      wofi
      pam
      mpd

      #X11 stuff
      xwayland-run
      wlogout
      hypridle
      hyprlock
      xdg-utils
      libnotify
      bibata-cursors

      #Nix Stuff
      home-manager
      nh
      alejandra
    ])
    ++ (with pkgs-unstable; [
      rustc
      rust-analyzer
      rustfmt

      blender
      cargo

      waypaper
    ]);
}
