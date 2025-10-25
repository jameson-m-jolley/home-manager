{ config, pkgs, ... }:

{
  # Define your user and home directory
  home.username = "jamesonj"; # Make sure this matches your actual username
  home.homeDirectory = "/home/jamesonj";
  nixpkgs.overlays = [
  		   (import (builtins.fetchTarball https://github.com/nix-community/emacs-overlay/archive/master.tar.gz))
		   ];
		   
nixpkgs.config.allowUnfree = true;
  # Install user packages
  home.packages = with pkgs; [
    git
    htop
    pkgs.emacsGcc
    steam
    discord
    spotify
    protonvpn-gui
    prismlauncher
    gcc
  ];
  


  # Example program configuration (e.g., for Zsh)
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -lh";
      update = "home-manager switch";
    };
  };
  
  # Ensure the Home Manager environment is active
  home.stateVersion = "25.05"; # Use your current NixOS version

  # ... other user-specific configurations (like desktop environment settings, other programs)
}
