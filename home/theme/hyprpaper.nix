{
  services.hyprpaper = {
    enable = true;

    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = ["/home/ionut/Pictures/akasaka1.png"];

      wallpaper = [
	  #      "HDMI-A-1,/home/ionut/Pictures/akasaka1.png"
	  # "eDP-1,/home/ionut/Pictures/akasaka1.png"
        ",/home/ionut/Pictures/akasaka1.png"
      ];
    };
  };
}
