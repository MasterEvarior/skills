{ lib, ... }: rec {
  mkSkills =
    pkgs: skills:
    let
      pkgsSet = builtins.listToAttrs (
        map (skill: lib.attrsets.nameValuePair (baseNameOf skill.src) (mkSkill pkgs skill)) skills
      );
    in
    pkgsSet
    // {
      default = pkgsSet.${baseNameOf (builtins.head skills).src};
    };
  mkSkill =
    pkgs: skill:
    pkgs.stdenv.mkDerivation {
      name = baseNameOf skill.src;
      src = skill.src;

      buildPhase = ''
        cp -r . $out

        cat ${mkFrontmatter { inherit pkgs skill; }} > $out/SKILL.md
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
        json = builtins.toJSON (extractFrontmatterContent skill);
        passAsFile = [ "json" ];
      }
      ''
        touch $out

        echo "---" > $out
        yj -jy < "$jsonPath" >> $out
        echo "---" >> $out
      '';
  extractFrontmatterContent = skill: {
    name = baseNameOf skill.src;
    description = skill.description;
  };
}
