{ lib, ... }:
{
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      name = "website-shell";

      packages = [
        pkgs.git
        pkgs.nodejs
      ];

      meta = {
        description = "The development shell for this website";
        platforms = lib.platforms.all;
      };
    };
  };
}
