{
  description = "NUR packages for hoard";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      legacyPackages = forAllSystems (pkgs: import ./default.nix { inherit pkgs; });
      packages = forAllSystems (pkgs: {
        hoard-artifact = (import ./default.nix { inherit pkgs; }).hoard-artifact;
      });
    };
}
