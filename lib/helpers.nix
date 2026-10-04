{ lib, ... }: rec {
  mkSkills =
    pkgs: skills:
    let
      pkgsSet = builtins.listToAttrs (
        map (skill: lib.attrsets.nameValuePair (baseNameOf skill.src) (mkSkill pkgs skill.src)) skills
      );
    in
    pkgsSet
    // {
      default = pkgsSet.${(builtins.head skills).name};
    };
  mkSkill =
    pkgs: src:
    pkgs.stdenv.mkDerivation {
      inherit src;

      name = baseNameOf src;

      buildPhase = ''
        cp -r . $out
      '';
    };
}
