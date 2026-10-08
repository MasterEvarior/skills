rec {

  /**
    Transform the attribute set of a skill into the relevant frontmatter,
    formatted as a YAML block. Each block is pre- and post-fixed with '---'
  */
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

  /**
    Extract the relevant content for the frontmatter,
    depending on which model (if any) is supplied
  */
  extractFrontmatterContent =
    {
      skill,
      model ? null,
    }:
    {
      name = if builtins.isAttrs skill.src then skill.src.name else baseNameOf skill.src;
      description = skill.description;
    }
    // (
      if (model == null || !(skill ? harnessSpecific.${model})) then
        { }
      else
        skill.harnessSpecific.${model}
    );
}
