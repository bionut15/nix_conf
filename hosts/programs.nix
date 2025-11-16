{
  config,
  inputs,
  pkgs,
  pkgs-unstable,
  ...
}: {
  programs = {
    zsh.enable = true;

    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/ionut/nix_conf/";
    };
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    git = {
    };

    #SSH config
    ssh = {
      startAgent = true;
    };

    xwayland.enable = true;

    #Hyprland setup
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    gamemode.enable = true;
  };
}
