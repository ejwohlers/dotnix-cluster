{ pkgs }:

{
  fmt = pkgs.writeShellApplication {
    name = "fmt";
    runtimeInputs = [ pkgs.nixpkgs-fmt ];
    text = "nixpkgs-fmt .";
  };

  statix = pkgs.writeShellApplication {
    name = "statix";
    runtimeInputs = [ pkgs.statix ];
    text = "statix check .";
  };

  deadnix = pkgs.writeShellApplication {
    name = "deadnix";
    runtimeInputs = [ pkgs.deadnix ];
    text = "deadnix .";
  };

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
}
