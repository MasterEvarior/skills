{ lib, buildHelper, ... }: rec {
  pkgsSkillsFor =
    {
      pkgs,
      skills,
      models,
    }:
    lib.foldl (a: b: a // b) { } (
      map (model: pkgSkills { inherit pkgs skills model; }) (models ++ [ null ])
    );
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
  mkPkgName =
    {
      src,
      model ? null,
    }:
    if model != null then "${baseNameOf src}-${model}" else (baseNameOf src);
}
