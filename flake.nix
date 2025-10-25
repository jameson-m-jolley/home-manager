
{
  description = "Home Manager configuration for jamesonj";

  inputs = {
    # Nixpkgs input is required
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05"; # Use your preferred branch/version

    # Home Manager input
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05"; # Match your nixpkgs version
      # Ensure Home Manager uses the same nixpkgs as the main input for consistency
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {

    # 1. DEFINE HOME MANAGER CONFIGURATIONS HERE
    homeConfigurations = {
      # The key MUST match your username!
      # In your case, this must be "jamesonj"
      "jamesonj" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Or your specific system architecture

        # 2. IMPORT YOUR USER CONFIGURATION
        modules = [
          ./home.nix
        ];
      };
    };
  };
}