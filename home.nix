{ config, pkgs, ... }:

{
  # Define your user and home directory
  home.username = "jamesonj"; # Make sure this matches your actual username
  home.homeDirectory = "/home/jamesonj";

nixpkgs.config.allowUnfree = true;
  # Install user packages
  home.packages = with pkgs; [
    git
    htop
    emacs
    steam
    discord
    spotify
    protonvpn-gui
    (atlauncher.overrideAttrs rec {
    pname = "atlauncher";
    version = "3.4.28.1";
    src = fetchurl {
      url = "https://github.com/ATLauncher/ATLauncher/releases/download/v${version}/ATLauncher-${version}.jar";
      hash = "sha256-IIwDMazxUMQ7nGQk/4VEZicgCmCR4oR8UYtO36pCEq4=";
    };
    installPhase = ''
      runHook preInstall
  
      mkdir -p $out/bin $out/share/java
      cp $src $out/share/java/ATLauncher.jar
  
      makeWrapper ${jre}/bin/java $out/bin/${pname} \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ xorg.libXxf86vm udev discord-rpc libglvnd ]}" \
        --add-flags "-jar $out/share/java/ATLauncher.jar" \
        --add-flags "--working-dir \"\''${XDG_DATA_HOME:-\$HOME/.local/share}/ATLauncher\"" \
        --add-flags "--no-launcher-update"
  
      mkdir -p $out/share/icons/hicolor/scalable/apps
      cp $ICON $out/share/icons/hicolor/scalable/apps/${pname}.svg
  
      runHook postInstall
    '';
  })
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
