{
  perSystem = { selfWithNodeModules, ... }: {
    treefmt = {
      projectRoot = selfWithNodeModules;
      projectRootFile = "flake.nix";

      programs = {
        keep-sorted.enable = true;
        nixfmt.enable = true;
        prettier.enable = true;
        shellcheck.enable = true;
        shfmt.enable = true;
      };

      settings.formatter.prettier = {
        includes = [ "*.astro" ];
      };
    };
  };
}
