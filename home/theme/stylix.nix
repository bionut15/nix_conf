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
    polarity = "light";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
    image = ./ghibliwall.png;

    targets.gtk.enable = true;
    targets.kde.enable = true;
    targets.dunst.enable = true;

    targets.kitty.enable = false;
    targets.alacritty.enable = false;
    targets.tmux.enable = true;
    targets.hyprland.enable = false;
    targets.waybar.enable = false;

    opacity = {
      terminal = 0.95;
    };
    cursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 22;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.geist-mono;
        name = "GeistMono Nerd Font Propo";
      };
      sansSerif = {
        package = pkgs.nerd-fonts.geist-mono;
        name = "GeistMono Nerd Font Propo";
      };
      #sansSerif = {
      #  package = pkgs.nerd-fonts.dejavu-sans-mono;
      #  name = "DejaVuSansM Nerd Font Mono";
      #};
      serif = {
        package = pkgs.nerd-fonts.dejavu-sans-mono;
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
