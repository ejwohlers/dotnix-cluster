{
  description = "🛰️ NixOS cluster powered by dotnix-cluster";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ nixpkgs, flake-parts, ... }:
    let
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
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      perSystem = { pkgs, ... }: {
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
        checks = import ./lib/checks.nix {
          inherit nixpkgs nixosConfigurations;
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        };
      };

    };
}
