{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
  };

  outputs =
    inputs:
    let
      pkgs = inputs.nixpkgs.legacyPackages;
      skills = (import ./skills/skills.nix);
      mkPkg =
        pkgs: name: src:
        pkgs.stdenv.mkDerivation {
          inherit name src;

          buildPhase = ''
            cp -r . $out
          '';

        };
    in
    {
      packages = builtins.mapAttrs (system: pkgs: {
        readme = mkPkg pkgs "create-readme" ./skills/create-readme;

        default = inputs.self.packages.${system}.readme;
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
