{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
  };

  outputs =
    inputs:
    let
      pkgs = inputs.nixpkgs.legacyPackages;
      lib = pkgs.lib;
    in
    {
      packages = builtins.mapAttrs (system: pkgs: {
        hello = pkgs.hello;

        default = inputs.self.packages.${system}.hello;
      }) pkgs;

      devshells = builtins.mapAttrs (system: pkgs: {
        default = pkgs.mkShell {
          shellHook = ''
            git config --local core.hooksPath .githooks/
          '';
        };
      }) pkgs;
    };
}
