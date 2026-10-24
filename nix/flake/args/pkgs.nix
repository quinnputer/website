{ inputs, ... }:
let
  config = {
    allowAliases = false;
  };
in
{
  perSystem = { system, ... }: {
    _module.args.pkgs = import inputs.nixpkgs { inherit system config; };
  };
}
