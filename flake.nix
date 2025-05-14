{
  description = "Home Manager configuration of estromenko";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixgl.url = "github:nix-community/nixGL";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixgl,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    formatter.x86_64-linux =
      nixpkgs.legacyPackages.x86_64-linux.alejandra;
    homeConfigurations."estromenko" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        nixgl = nixgl;
      };
      modules = [./home.nix];
    };
  };
}
