{ config, pkgs, ... }:

{
home.username = "ionut";
home.homeDirectory = "/home/ionut";
home.pointerCursor = {
	gtk.enable = true;
	name = "Bibata-modern-ice";
	package = pkgs.bibata-cursors; size = 22; 
};
#Theming
#GTK 
gtk.enable = true;

gtk.cursorTheme.package = pkgs.bibata-cursors;
gtk.cursorTheme.name = "Bibata-Modern-Ice";

gtk.theme.name = "gruvbox-gtk-theme";
gtk.theme.package = pkgs.gruvbox-gtk-theme;
gtk ={
	gtk3 = {
		extraConfig = {
			gtk-application-prefer-dark-theme = 1;
		};
	};
	gtk4 = {
		extraConfig = {
			gtk-application-prefer-dark-theme = 1;
		};
	};
};

dconf = {
	enable = true;
	settings = {
		"org/gnome/desktop/interface" = {
		  color-scheme = "prefer-dark";
		  #gtk-theme = "gruvbox-gtk-theme";
		};
	};
};
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
	VISUAL = "neovim";
	EDITOR = "neovim";
	GTK_THEME = "gruvbox-gtk-theme";
};
#XDG settings
xdg.mime.enable = true;
xdg.mimeApps = {
	enable = true;
	associations.added = {
		"application/pdf" = ["org.pwmt.zathura.desktop"];
	};
	defaultApplications = {
		"application/pdf" = ["org.pwmt.zathura.desktop"];
	};
};
#Programs configs
programs.git = {
	enable = true;
	userName = "Ionut";
	userEmail = "barborionut15@gmail.com";
};

programs.starship = {
	enable = true;
	     # Configuration written to ~/.config/starship.toml
	settings = {
		add_newline = false;
		format = "$shlvl$shell$username$hostname$nix_shell$git_branch$git_commit$git_state$git_status$directory$jobs$cmd_duration$character";
		shlvl = {
			disabled = false;
			symbol = "ﰬ ";
			style = "bright-red bold";
		};
		shell = {
			disabled = false;
			format = "$indicator";
			bash_indicator = "[](bright-white) ";
		};
		username = {
			style_user = "bright-white bold";
			style_root = "bright-red bold";
		};
		hostname = {
			style = "bright-green bold";
			ssh_only = true;
		};
		nix_shell = {
			symbol = " ";
			format = "[$symbol$name]($style) ";
			style = "bright-purple bold";
		};
		git_branch = {
			only_attached = true;
			format = "[$symbol$branch]($style) ";
			symbol = " ";
			style = "bright-yellow bold";
		};
		git_commit = {
			only_detached = true;
			format = "[ﰖ $hash]($style) ";
			style = "bright-yellow bold";
		};
		git_state = {
			style = "bright-purple bold";
		};
		git_status = {
			style = "bright-green bold";
		};
		directory = {
			read_only = " ";
			truncation_length = 0;
		};
		cmd_duration = {
			format = "[$duration]($style) ";
			style = "bright-blue";
		};
		jobs = {
			style = "bright-green bold";
		};
		character = {
			success_symbol = "[❯](bright-green bold)";
			error_symbol = "[❯](bright-red bold)";
		};
	};
};

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

programs.wofi ={
	enable = true;
	settings = {
	
	};
	style = ''
		window {
		margin: 0px;
		border-radius:0.4em;
		border: 1px solid #928374;
		background-color: #282828;
		}
		
		#input {
		margin: 5px;
		border: none;
		color: #ebdbb2;
		background-color: #1d2021;
		}
		
		#inner-box {
		margin: 5px;
		border: none;
		background-color: #282828;
		}
		
		#outer-box {
		margin: 5px;
		border: none;
		background-color: #282828;
		}
		
		#scroll {
		margin: 0px;
		border: none;
		}
		
		#text {
		margin: 5px;
		border: none;
		color: #ebdbb2;
		}
		
		#entry:selected {
		background-color: #1d2021;
		}
		#entry:unselected {
		color: black;
		}
	'';
};

programs.lf ={
	enable = true;
	keybindings ={
		"." = "set hidden!";
		"<esc>" = "cmd-escape";
	};
};

programs.alacritty = {
	enable = true;
	# custom settings
	settings = {
		#optional fish config 
		#shell = {
		#	#program = "/run/current-system/sw/bin/fish";
		#};
		env.TERM = "xterm-256color";
		window.opacity =0.8;
		window.padding = {
			x = 2;
			y = 2;
		};
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
		};
		scrolling.multiplier = 5;
		selection.save_to_clipboard = true;
		keyboard = {
			bindings = [{ key = "F11" ;action = "ToggleFullscreen";}];
		};
	};
};

#Services
services.dunst = {
	enable = true;
	settings = {
		global = {
		  rounded = "yes";
		  origin = "top-right";
		  alignment = "left";
		  vertical_alignment = "center";
		  width = "400";
		  height = "400";
		  scale = 0;
		  gap_size = 0;
		  progress_bar = true;
		  transparency = 1;
		  text_icon_padding = 0;
		  separator_color = "frame";
		  sort = "yes";
		  idle_threshold = 120;
		  line_height = 0;
		  markup = "full";
		  show_age_threshold = 60;
		  ellipsize = "middle";
		  ignore_newline = "no";
		  stack_duplicates = true;
		  sticky_history = "yes";
		  history_length = 20;
		  always_run_script = true;
		  corner_radius = 10;
		  follow = "mouse";
		  font = "Source Sans Pro 10";
		  format = "<b>%s</b>\\n%b"; #format = "<span foreground='#f3f4f5'><b>%s %p</b></span>\n%b"
		  frame_color = "#232323";
		  frame_width = 1;
		  offset = "15x15";
		  horizontal_padding = 10;
		  icon_position = "left";
		  indicate_hidden = "yes";
		  min_icon_size = 0;
		  max_icon_size = 64;
		  mouse_left_click = "do_action, close_current";
		  mouse_middle_click = "close_current";
		  mouse_right_click = "close_all";
		  padding = 10;
		  plain_text = "no";
		  separator_height = 2;
		  show_indicators = "yes";
		  shrink = "no";
		  word_wrap = "yes";
		  browser = "/usr/bin/env firefox -new-tab";
		};
		
		fullscreen_delay_everything = {fullscreen = "delay";};
		
		urgency_critical = {
		  background = "#d64e4e";
		  foreground = "#f0e0e0";
		};
		urgency_low = {
		  background = "#232323";
		  foreground = "#2596be";
		};
		urgency_normal = {
		  background = "#1e1e2a";
		  foreground = "#2596be";
		};
	};
};

imports = [

];

programs.home-manager.enable = true;
}
