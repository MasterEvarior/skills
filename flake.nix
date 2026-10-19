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
      helpers = pkgs: (import ./lib/helpers.nix { inherit lib pkgs; }).helpers;
      skills =
        pkgs:
        (import ./skills/skills.nix {
          inherit pkgs;
          fetchHelpers = (helpers pkgs).fetch;
        });
      models = [
        "claude"
        "opencode"
      ];
      buildAll =
        pkgs:
        ((helpers pkgs).package.pkgsSkillsFor {
          inherit pkgs models;
          skills = (skills pkgs);
        });
      combineAll = pkgs: pkgs.linkFarmFromDrvs "skills" (lib.attrValues (buildAll pkgs));
      hasModelSuffix = str: builtins.any (suffix: lib.hasSuffix suffix str) models;
      removeHarnessSpecificPackages = skillPkgs: builtins.filter (p: !hasModelSuffix p.name) skillPkgs;
      listOfSkills =
        skillPkgs:
        map (p: "| ${p.name} | ${p.value.meta.longDescription} |") (
          removeHarnessSpecificPackages (lib.attrsToList skillPkgs)
        );
    in
    {
      packages = builtins.mapAttrs (
        _system: pkgs:
        (buildAll pkgs)
        // {
          default = combineAll pkgs;
          list = pkgs.runCommand "skill-list" { } ''
            mkdir $out

            FILE="$out/list.md"
            touch "$FILE"

            echo "| Name | Description |" > "$FILE"
            echo "| ---- | ----------- |" >> "$FILE"
            echo "${builtins.concatStringsSep "\n" (listOfSkills (buildAll pkgs))}" >> "$FILE"
          '';
        }
      ) pkgs;

      devshells = builtins.mapAttrs (_system: pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            mdsh
          ];

          shellHook = ''
            git config --local core.hooksPath .githooks/
          '';
        };
      }) pkgs;

      formatter = builtins.mapAttrs (
        _system: pkgs:
        (inputs.treefmt-nix.lib.evalModule pkgs {
          projectRootFile = "flake.nix";
          programs.mdformat.enable = true;
          programs.deadnix.enable = true;
          programs.nixfmt.enable = true;
          programs.mdsh.enable = true;
        }).config.build.wrapper
      ) pkgs;
    };
}
