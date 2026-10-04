{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      pkgs = inputs.nixpkgs.legacyPackages;
      lib = inputs.nixpkgs.lib;
      skills = (import ./skills/skills.nix);
      helpers = (import ./lib/helpers.nix { inherit lib; });
    in
    {
      packages = builtins.mapAttrs (system: pkgs: (helpers.mkSkills pkgs skills)) pkgs;

      devshells = builtins.mapAttrs (system: pkgs: {
        default = pkgs.mkShell {
          shellHook = ''
            git config --local core.hooksPath .githooks/
          '';
        };
      }) pkgs;

      formatter = builtins.mapAttrs (
        system: pkgs:
        (inputs.treefmt-nix.lib.evalModule pkgs {
          projectRootFile = "flake.nix";
          programs.mdformat.enable = true;
        }).config.build.wrapper
      ) pkgs;
    };
}
