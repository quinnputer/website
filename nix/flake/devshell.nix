{ lib, ... }:
{
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      name = "website-shell";

      packages = [
        pkgs.cocogitto
        pkgs.git
        pkgs.nodejs
        pkgs.secretspec
      ];

      shellHook = ''
        cog install-hook --all --overwrite
      '';

      meta = {
        description = "The development shell for this website";
        platforms = lib.platforms.all;
      };
    };
  };
}
