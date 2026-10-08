{ lib, pkgs, ... }:
let
  build = (import ./build-helper.nix);
  package = (
    import ./package-helper.nix {
      inherit lib;
      buildHelper = build;
    }
  );
  fetch = (import ./fetch-helper.nix { inherit pkgs; });
in
{
  helpers = {
    inherit
      build
      package
      fetch
      ;
  };
}
