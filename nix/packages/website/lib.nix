{
  lib,
  pkgs,
  self,
  ...
}:
let
  modules = [
    ./module.nix
    { _module.args.pkgs = pkgs; }
    { _module.args.self = self; }
  ];

  evalModule = module: lib.evalModules { modules = modules ++ [ module ]; };
  withConfig = config: (evalModule config).config.output;
in
{
  inherit withConfig;
}
