{
  description = "wl_shimeji flake";

  inputs = {
    self.submodules = true;
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" ];

      perSystem = { config, pkgs, ... }: {
        packages = {
          wl_shimeji = pkgs.callPackage ./nix/package.nix { inherit (config.packages) wl_shimeji-unwrapped; };
          wl_shimeji-unwrapped = pkgs.callPackage ./nix/unwrapped.nix { };
          default = config.packages.wl_shimeji;
        };
      };
    };
}
