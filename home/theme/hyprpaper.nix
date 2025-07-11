{
  services.hyprpaper = {
    enable = true;

    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = ["/home/ionut/Pictures/Minecraft_1.jpeg"];

      wallpaper = [
        "HDMI-A-1,/home/ionut/Pictures/Minecraft_1.jpeg"
        "eDP-1,/home/ionut/Pictures/Minecraft_1.jpeg"
      ];
    };
  };
}
