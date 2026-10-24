{
  description = "My beautiful website";
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } ./nix/flake;

  inputs = {
    # keep-sorted start block=yes newline_separated=yes
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };

    systems = {
      url = "github:nix-systems/triplet";
    };

    treefmt = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # keep-sorted end
  };
}
