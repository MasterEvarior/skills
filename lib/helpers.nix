{ lib, ... }: rec {
  mkSkills =
    {
      pkgs,
      skills,
      model ? null,
    }:
    let
      pkgsSet = builtins.listToAttrs (
        map (
          skill:
          lib.attrsets.nameValuePair (baseNameOf skill.src) (mkSkill {
            inherit pkgs skill model;
          })
        ) skills
      );
    in
    pkgsSet
    // {
      default = pkgsSet.${baseNameOf (builtins.head skills).src};
    };
  mkSkill =
    {
      pkgs,
      skill,
      model ? null,
    }:
    pkgs.stdenv.mkDerivation {
      name = baseNameOf skill.src;
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
    // (if model == null then { } else skill.harnessSpecific.${model});
}
