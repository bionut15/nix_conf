{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = false;
  };
}
