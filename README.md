![CI](https://github.com/YOUR-USER/dotnix-cluster/actions/workflows/ci.yml/badge.svg)

# 🛰️ dotnix-cluster

A modular, reproducible NixOS cluster powered by **flakes**, **flake-parts**, and clean per-host configurations.

This setup is designed for managing your physical or virtual NixOS machines using a GitOps approach — and it's CI-validated!

---

## 📦 Features

- ⚙️ **Per-host NixOS configurations** (`orion`, `vega`, `nova`)
- ✅ **Flake checks** with `statix`, `deadnix`, and `nixpkgs-fmt`
- 🔁 **Pre-commit hooks** (Nix-native)
- 🧪 **GitHub Actions CI**
- 🌱 Ready for `deploy-rs`, ISO builds, secrets management, etc.

---

## 📁 Structure

dotnix-cluster/ 
    ├── flake.nix # Main flake configuration 
    ├── lib/checks.nix # All lint/CI checks (flake-native) 
    ├── hosts/ # Per-node NixOS configs 
    │ 
    ├── orion.nix 
    │ 
    ├── vega.nix 
    │ 
    └── nova.nix 
    └── modules/ # Optional shared config modules

---

## 🧪 Usage

### ✅ Run checks

```bash
nix flake check

Or individually:

nix run .#checks.x86_64-linux.fmt
nix run .#checks.x86_64-linux.statix
nix run .#checks.x86_64-linux.deadnix
nix run .#checks.x86_64-linux.pre-commit-all

### 💻 Dev shell

nix develop
pre-commit run --all-files