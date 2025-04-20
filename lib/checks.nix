{ pkgs }:

{
  x86_64-linux = {
    fmt = pkgs.writeShellApplication {
      name = "fmt-check";
      runtimeInputs = [ pkgs.nixpkgs-fmt ];
      text = "nixpkgs-fmt --check .";
    };

    statix = pkgs.writeShellApplication {
      name = "statix-check";
      runtimeInputs = [ pkgs.statix ];
      text = "statix check .";
    };

    deadnix = pkgs.writeShellApplication {
      name = "deadnix-check";
      runtimeInputs = [ pkgs.deadnix ];
      text = "deadnix .";
    };

    pre-commit = pkgs.writeShellApplication {
      name = "pre-commit-check";
      runtimeInputs = with pkgs; [ statix deadnix nixpkgs-fmt ];
      text = ''
        echo "🔍 Running statix..."
        statix check .

        echo "🧹 Running deadnix..."
        deadnix .

        echo "🎨 Running nixpkgs-fmt..."
        nixpkgs-fmt --check .
      '';
    };

    # Optionally, bundle them all under one runner:
    pre-commit-all = pkgs.writeShellApplication {
      name = "pre-commit-all";
      runtimeInputs = with pkgs; [ statix deadnix nixpkgs-fmt ];
      text = ''
        echo "🔍 Running statix..."
        statix check .

        echo "🧹 Running deadnix..."
        deadnix .

        echo "🎨 Running nixpkgs-fmt..."
        nixpkgs-fmt --check .
      '';
    };
  };
}
