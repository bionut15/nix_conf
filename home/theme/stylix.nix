{
  config,
  pkgs,
  stylix,
  lib,
  ...
}: {
  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 22;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.package = pkgs.adwaita-qt;
    style.name = "adwaita-dark";
  };

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    image = ./ghibliwall.png;

    targets.gtk.enable = true;
    targets.kde.enable = true;
    targets.dunst.enable = true;

    targets.kitty.enable = false;
    targets.alacritty.enable = true;
    targets.tmux.enable = false;
    targets.hyprland.enable = false;
    targets.waybar.enable = false;

    opacity = {
      terminal = 0.9;
    };
    cursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 22;
    };

    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
        name = "JetBrainsMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sizes = {
        applications = 10;
        terminal = 12;
        desktop = 10;
        popups = 10;
      };
    };
  };
}
