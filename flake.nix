{
  description = "🛰️ NixOS cluster powered by dotnix-cluster";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    #flake-parts.inputs.nixpkgs.follows = "nixpkgs"; # ✨ ensures consistency
  };

  outputs = inputs@{ nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      perSystem = { system, pkgs, ... }: {
        checks = import ./lib/checks.nix { inherit pkgs; };

        devShells.default = pkgs.mkShell {
          name = "dotnix-cluster-dev";
          packages = with pkgs; [
            nixpkgs-fmt
            statix
            deadnix
            pre-commit
            git
            openssh
          ];
        };
      };

      flake = {
        nixosConfigurations = {
          orion = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [ ./hosts/orion.nix ];
          };
          vega = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [ ./hosts/vega.nix ];
          };
          nova = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [ ./hosts/nova.nix ];
          };
        };
      };
    };
}
