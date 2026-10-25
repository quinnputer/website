{ inputs, ... }:
{
  imports = [
    inputs.treefmt.flakeModule

    ./args

    ./devshell.nix
    ./packages.nix
    ./systems.nix
    ./treefmt.nix
  ];
}
