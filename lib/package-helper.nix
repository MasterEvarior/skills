{ lib, buildHelper, ... }: rec {
  /**
    Package a list of skills for a list of models
  */
  pkgsSkillsFor =
    {
      pkgs,
      skills,
      models,
    }:
    lib.foldl (a: b: a // b) { } (
      map (model: pkgSkills { inherit pkgs skills model; }) (models ++ [ null ])
    );

  /**
    Package a list of skills
  */
  pkgSkills =
    {
      pkgs,
      skills,
      model ? null,
    }:
    builtins.listToAttrs (
      map (
        skill:
        lib.attrsets.nameValuePair
          (mkPkgName {
            src = skill.src;
            inherit model;
          })
          (pkgSkill {
            inherit pkgs skill model;
          })
      ) skills
    );

  /**
    Package a single skill
  */
  pkgSkill =
    {
      pkgs,
      skill,
      model ? null,
    }:
    pkgs.stdenv.mkDerivation {
      name = mkPkgName {
        src = skill.src;
        inherit model;
      };
      src = skill.src;

      buildPhase = ''
        cp -r . $out

        cat ${buildHelper.mkFrontmatter { inherit pkgs skill model; }} > $out/SKILL.md
        cat SKILL.md >> $out/SKILL.md
      '';
    };

  /**
    Create the name of a package from their source

    # Examples

    ```nix
    mkPkgName { src = ./my-skill; }
    =>
    my-skill
    ```

        ```nix
    mkPkgName { src = ./my-skill; model = "claude"; }
    =>
    my-skill-claude
    ```
  */
  mkPkgName =
    {
      src,
      model ? null,
    }:
    if model != null then "${baseNameOf src}-${model}" else (baseNameOf src);
}
