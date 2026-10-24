{ self, ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      nodeModules = pkgs.importNpmLock.buildNodeModules {
        inherit (pkgs) nodejs;
        npmRoot = self;
      };
    in
    {
      _module.args.selfWithNodeModules = pkgs.runCommand "make-project-root" { } ''
        mkdir -p "$out"
        cp -r "${self}/." "$out"
        cp -r "${nodeModules}/node_modules" "$out/node_modules"
      '';
    };
}
