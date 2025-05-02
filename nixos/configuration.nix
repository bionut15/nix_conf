{
  config,
  inputs,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub.enable = true;
  boot.loader.grub.devices = ["nodev"];
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;

  boot.supportedFilesystems = ["ntfs"];

  networking.hostName = "nixos";
  networking.firewall = {
    allowedTCPPorts = [2222 443 8080];
    enable = false;
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Bucharest";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ro_RO.UTF-8";
    LC_IDENTIFICATION = "ro_RO.UTF-8";
    LC_MEASUREMENT = "ro_RO.UTF-8";
    LC_MONETARY = "ro_RO.UTF-8";
    LC_NAME = "ro_RO.UTF-8";
    LC_NUMERIC = "ro_RO.UTF-8";
    LC_PAPER = "ro_RO.UTF-8";
    LC_TELEPHONE = "ro_RO.UTF-8";
    LC_TIME = "ro_RO.UTF-8";
  };

  services.xserver.videoDrivers = ["amdgpu"];
  services.xserver = {
    desktopManager.gnome.enable = true;
    enable = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-session --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ionut = {
    isNormalUser = true;
    description = "ionut";
    extraGroups = [
      "input"
      "audio"
      "networkmanager"
      "wheel"
      "video"
    ];
    packages = with pkgs; [];
  };

  #default shell also bash
  users.defaultUserShell = pkgs.zsh;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.warn-dirty = false;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # List packages installed in system profile.

  environment.systemPackages =
    (with pkgs; [
      #bluetooth and sound
      pipewire
      wireplumber
      alsa-lib
      pwvucontrol
      bluez-tools
      bluez

      #Utils
      rar
      unzip
      zip
      brillo

      brightnessctl
      networkmanager
      networkmanagerapplet

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

      #hyprpanel
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

  #fonts
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "CascadiaMono"
        "Noto"
        "GeistMono"
      ];
    })
  ];
  #Wayland
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk];

  # Services

  security.rtkit.enable = true;

  services.power-profiles-daemon.enable = false;

  services = {
    printing = {
      enable = true;
      drivers = [pkgs.hplipWithPlugin pkgs.hplip];
      listenAddresses = ["*:631"];
      allowFrom = ["all"];
      browsing = true;
      defaultShared = true;
      openFirewall = true;
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };

    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "never";
        };
      };
    };

    logind = {
      lidSwitch = "suspend";
      lidSwitchDocked = "suspend";
      lidSwitchExternalPower = "suspend";
    };
    flatpak.enable = true;

    pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.extraConfig = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.roles" = ["hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag"];
        };
      };
    };

    blueman.enable = true;

    udisks2.enable = true;
    udev.packages = [
      pkgs.platformio-core
      pkgs.openocd
    ];

    mpd = {
      enable = true;
      startWhenNeeded = true;
    };
  };

  #programs
  programs.zsh.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/ionut/.config/nix_conf/";
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  #SSH config
  programs.ssh = {
    startAgent = true;
  };

  # Enable  the OpenSSH daemon.
  services.openssh.enable = true;

  programs.xwayland.enable = true;
  #Hyprland setup
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.steam = {
    enable = true;
  };
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  environment.sessionVariables = {
    KWIN_DRM_NO_AMS = "1";
    WLR_NO_HARDWARE_CURSOR = "1";
    NIXOS_OZONE_WL = "1";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
  hardware = {
    graphics.enable = true;
    cpu.amd.updateMicrocode = true;

    pulseaudio.enable = false;
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
    bluetooth.settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };
  environment.etc = {
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
