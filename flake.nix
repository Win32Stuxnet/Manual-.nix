{
  description = "NixOS configuration with Home Manager";

  inputs = {
    # NixOS stable channel
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations."iusenixosBTW" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.alanaa = import ./home.nix;
        }
      ];
    };
  };
}

