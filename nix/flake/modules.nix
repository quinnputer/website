{ self, ... }:
{
  flake.nixosModules.default = import "${self}/nix/modules" { inherit self; };
}
