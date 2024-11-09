# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  inputs,
  pkgs,
  pkgs-unstable,
  ...
}: let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  #Systemd-boot
  #systemd = {
  #  sleep.extraConfig = ''
  #    AllowSuspend=no
  #    AllowHibernation=no
  #    AllowHybridSleep=no
  #    AllowSuspendThenHibernate=no
  #  '';
  #};

  #boot.loader.systemd-boot.enable = true;
  #boot.loader.systemd-boot.consoleMode = "keep";
  #boot.loader.systemd-boot.configurationLimit = 10;
  #boot.loader.systemd-boot.extraEntries ={
  #      "windows.conf"=''
  #      title Windows
  #      efi /dev/nvme0n1p1@/efi/Microsoft/Boot/bootmgfw.efi
  #      sort-key o_memtest
  #      '';
  #};

  #boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub.enable = true;
  boot.loader.grub.devices = ["nodev"];
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;

  boot.supportedFilesystems = ["ntfs"];
  networking.hostName = "nixos"; # Define your hostname.
  networking.firewall = {
    allowedTCPPorts = [443 8080];
    enable = false;
  };
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

  services.xserver.videoDrivers = ["nvidia"];

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

  users.defaultUserShell = pkgs.fish;

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
      alsaLib
      pavucontrol
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
      speedtest-cli

      lazygit
      git
      starship
      wl-clipboard
      grim
      slurp
      nsxiv
      zathura
      lf
      kitty
      trash-cli
      pistol
      imagemagick
      ghostscript
      poppler
      hplipWithPlugin
      cups

      tmux
      mpv
      lsd
      cava
      lshw
      pandoc
      texliveTeTeX

      obsidian
      obs-studio
      ffmpeg

      #utilities
      fish
      entr
      udiskie
      udisks
      ncdu
      btop
      nvitop

      asusctl

      discord
      webcord
      signal-desktop
      jre
      # Javascriptar
      pnpm
      nodejs
      nodePackages.live-server

      neovim
      inkscape
      libreoffice
      librecad
      gnome.gnome-calculator
      freecad

      firefox

      fastfetch
      blender
      lutris
      inputs.pollymc.packages.${pkgs.system}.pollymc

      heroic
      wine
      wine-wayland
      wineWowPackages.stable
      wineWowPackages.waylandFull

      bottles
      fragments
      alacritty

      wget
      gnome.gnome-clocks
      gnome.nautilus
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

      #style formatter
      lua54Packages.luacheck
      lua-language-server
      stylua
      nodePackages_latest.prettier

      #GTK
      gtk2
      gtk3
      gtk4
      lxappearance-gtk2
      gnome.gnome-themes-extra
      gtk-engine-murrine
      gruvbox-gtk-theme
      gruvbox-dark-gtk

      #Hyprland rice

      qt5.qtwayland
      qt6.qtwayland
      pkgs.dunst
      waybar
      nwg-displays
      wofi
      pam
      mpd
      hyprland
      wlogout
      hypridle
      hyprlock
      hyprpaper
      swaybg
      waypaper
      xdg-desktop-portal-hyprland
      xdg-utils
      libnotify
      bibata-cursors

      #Secure boot
      sbctl
      niv

      #Nix Stuff
      home-manager
      nh
      alejandra
    ])
    ++ (with pkgs-unstable; [
      rustc
      rust-analyzer
      rustfmt
      cargo

      waypaper
    ]);

  #fonts
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
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
  # Services

  security.rtkit.enable = true;

  services = {
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

    asusd = {
      enable = true;
      profileConfig = "Quiet";
      enableUserService = true;
      userLedModesConfig = "strobe";
    };

    udisks2.enable = true;
    printing.enable = true;
    printing.drivers = [pkgs.hplip pkgs.hplipWithPlugin];

    mpd = {
      enable = true;
      startWhenNeeded = true;
    };
  };

  #programs
  programs.fish.enable = true;
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/ionut/.config/home-manager";
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  #SSH config
  programs.ssh = {
    startAgent = true;
  };
  users.users."ionut".openssh.authorizedKeys.keyFiles = [
    /home/ionut/.ssh/keygen
  ];

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
    WLR_NO_HARDWARE_CURSOR = "1";
    NIXOS_OZONE_WL = "1";
    EDITOR = "nvim";
    VISUAL = "nvim";
    TERM = "kitty";
    FLAKE = "/home/ionut/.config/home-manager";
  };
  hardware = {
    opengl.enable = true;
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
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;

      prime = {
        sync.enable = true;
        #change offload when need to be separte
        #offload = {
        #  enable = true;
        #  enableOffloadCmd = true;
        #};
        amdgpuBusId = "PCI:5:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      #package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      #  version = "555.58.02";
      #  sha256_64bit = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
      #  sha256_aarch64 = "sha256-wb20isMrRg8PeQBU96lWJzBMkjfySAUaqt4EgZnhyF8=";
      #  openSha256 = "sha256-8hyRiGB+m2hL3c9MDA/Pon+Xl6E788MZ50WrrAGUVuY=";
      #  settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
      #  persistencedSha256 = "sha256-a1D7ZZmcKFWfPjjH1REqPM5j/YLWKnbkP9qfRyIyxAw=";
      #};
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

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
