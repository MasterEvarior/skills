{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
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
      models = [ "claude" ];
      buildAll = pkgs: (helpers.mkSkillsAllModels { inherit pkgs skills models; });
    in
    {
      packages = builtins.mapAttrs (
        system: pkgs:
        (buildAll pkgs)
        // {
          default = pkgs.linkFarmFromDrvs "skills" (lib.attrValues (buildAll pkgs));
        }
      ) pkgs;

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
