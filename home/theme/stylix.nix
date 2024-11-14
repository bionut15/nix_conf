{
  config,
  pkgs,
  stylix,
  ...
}: {
  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-modern-ice";
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
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
    image = /home/ionut/Pictures/Wallpaper/ghibliwall.png;

    targets.gtk.enable = true;

    targets.kitty.enable = false;
    targets.alacritty.enable = false;
    targets.dunst.enable = false;
    #targets.tmux.enable = false;
    targets.waybar.enable = false;

    #cursor = {
    #  name = "Bibata-modern-ice";
    #  package = pkgs.bibata-cursors;
    #  size = 22;
    #};
  };
}
