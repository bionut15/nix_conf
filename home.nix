{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ionut";
  home.homeDirectory = "/home/ionut";
   home.pointerCursor = {
    gtk.enable = true;
    name = "Bibata-modern-ice";
    package = pkgs.bibata-cursors;
    size = 22;
  };
  #GTK 
  gtk.enable = true;
  
  gtk.cursorTheme.package = pkgs.bibata-cursors;
  gtk.cursorTheme.name = "Bibata-Modern-Ice";
  
  gtk.theme.package = pkgs.gruvbox-dark-gtk;
  gtk.theme.name = "gruvbox-dark-gtk";

  #QT config
  qt.enable = true;
  qt.platformTheme.name = "gtk";
  qt.style.name = "adwaita-dark";
  qt.style.package = pkgs.adwaita-qt;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ionut/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
     EDITOR = "neovim";
  };


  #Programs configs
  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = "
	if [ -f $HOME/.config/home-manager/.bashrc ];
	then
	  source $HOME/.config/home-manager/.bashrc
	fi
	";
	shellAliases ={
		v="nvim";
		homec="nvim .config/home-manager/home.nix";
		nconfig = "sudo nvim /etc/nixos/configuration.nix";
	};
   };

  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      window.opacity =0.8;
      colors.primary= {
		background = "#282828";
		foreground = "#ebdbb2";
      };
      colors.normal = {
      		black   = "#282828";
		red     = "#cc241d";
		green   = "#98971a";
		yellow  = "#d79921";
		blue    = "#458588";
		magenta = "#b16286";
		cyan    = "#689d6a";
		white   = "#a89984";
      };
      colors.bright = {
		black   = "#928374";
		red     = "#fb4934";
		green   = "#b8bb26";
		yellow  = "#fabd2f";
		blue    = "#83a598";
		magenta = "#d3869b";
		cyan    = "#8ec07c";
		white   = "#ebdbb2";
      };
      font = {
	normal = {family = "JetBrainsMono Nerd Font" ;style = "Regular";};
        size = 12;
        #draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  imports = [
        #./modules/programs/alacritty.nix
  ];

  # Let Home Manager install and manage itself.
  
  programs.home-manager.enable = true;
}
