{ inputs, ... }:
{
  imports = [
    inputs.treefmt.flakeModule

    ./args

    ./devshell.nix
    ./modules.nix
    ./packages.nix
    ./systems.nix
    ./treefmt.nix
  ];
}
