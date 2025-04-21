{
  description = "🛰️ NixOS cluster powered by dotnix-cluster";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, flake-parts, sops-nix, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      perSystem = { pkgs, ... }: {
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
            modules = [ 
              ./hosts/orion.nix
              sops-nix.nixosModules.sops
            ];
          };
          vega = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [ 
              ./hosts/vega.nix
              sops-nix.nixosModules.sops
            ];
          };
          nova = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [ 
              ./hosts/nova.nix 
              sops-nix.nixosModules.sops
            ];
          };
        };
      };
    };
}
