{ config, pkgs, stdenv, lib, ...}:

{
  # Define your user and home directory
  home.username = "jamesonj"; # Make sure this matches your actual username
  home.homeDirectory = "/home/jamesonj";

nixpkgs.config.allowUnfree = true;
  # Install user packages
  home.packages = with pkgs; [
    pkgs.gfortran
    (pkgs.lib.hiPrio pkgs.gcc) # This makes GCC win the conflict
    git
    htop
    emacs
    ripgrep
    steam
    discord
    spotify
    protonvpn-gui
    prismlauncher
    coreutils # basic GNU utilities
    fd
    zig 
    gcc
    clang-tools
    neofetch
    ffmpeg
    #crealityPrint
    flatpak
    valgrind
    openvpn
    vscode
    (pkgs.python311.withPackages (ps: with ps; [
      # Example: A CLI tool you want globally
      black
      # Example: A library whose binary you want available (less common)
      # You can even install pip itself this way, though it's often better
      # to use it in a venv, as shown below.
      pip
      jupyterlab
      pandas
      matplotlib
      numpy
      manim
    ]))
    sbcl
    quicklisp
    openssl
    zlib 
  ];

#services.flatpak.enable = true;
#environment.systemPackages = [ pkgs.flatpak-builder ];


  # Example program configuration (e.g., for Zsh)
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -lh";
      update = "home-manager switch";
    };
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };

  # Ensure the Home Manager environment is active
  home.stateVersion = "25.05"; # Use your current NixOS version

  # ... other user-specific configurations (like desktop environment settings, other programs)
}
