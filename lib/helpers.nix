{ lib, ... }: rec {
  mkSkillsAllModels =
    {
      pkgs,
      skills,
      models,
    }:
    lib.foldl (a: b: a // b) { } (
      map (model: mkSkills { inherit pkgs skills model; }) (models ++ [ null ])
    );
  mkSkills =
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
          (mkSkill {
            inherit pkgs skill model;
          })
      ) skills
    );
  mkPkgName =
    {
      src,
      model ? null,
    }:
    if model != null then "${baseNameOf src}-${model}" else (baseNameOf src);
  mkSkill =
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

        cat ${mkFrontmatter { inherit pkgs skill model; }} > $out/SKILL.md
        cat SKILL.md >> $out/SKILL.md
      '';
    };
  mkFrontmatter =
    {
      pkgs,
      skill,
      model ? null,
    }:
    pkgs.runCommand "toFrontmatter"
      {
        buildInputs = with pkgs; [ yj ];
        json = builtins.toJSON (extractFrontmatterContent {
          inherit skill model;
        });
        passAsFile = [ "json" ];
      }
      ''
        touch $out

        echo "---" > $out
        yj -jy < "$jsonPath" >> $out
        echo "---" >> $out
      '';
  extractFrontmatterContent =
    {
      skill,
      model ? null,
    }:
    {
      name = baseNameOf skill.src;
      description = skill.description;
    }
    // (
      if (model == null || !(skill ? harnessSpecific.${model})) then
        { }
      else
        skill.harnessSpecific.${model}
    );
}
