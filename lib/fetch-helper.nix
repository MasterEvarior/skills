{ pkgs }:
{
  fetchFromGitSrc =
    {
      name,
      url,
      rev,
      rootDir ? "/",
      hash,
    }:
    let
      src = pkgs.fetchgit {
        inherit
          url
          rev
          rootDir
          hash
          ;
      };
    in
    pkgs.runCommand "${name}" { } ''
      mkdir -p "$out"
      cp -r ${src}/. "$out"

      file="$out/SKILL.md"
      if [ -f "$file" ] && head -n1 "$file" | grep -q '^---$'; then
        sed '1,/^---$/d' "$file" > "$file.tmp" && mv "$file.tmp" "$file"
      fi
    '';
}
