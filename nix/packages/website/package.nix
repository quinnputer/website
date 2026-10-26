{ self, callPackages }:
let
  lib = callPackages ./lib.nix { inherit self; };
in
lib.withConfig { }
