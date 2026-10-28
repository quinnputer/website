{ self }:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.website;
  package = (lib.getAttr pkgs.stdenv.hostPlatform.system self.packages).website;
in
{
  options.services.website = {
    enable = lib.mkEnableOption "emo.gay website";

    package = lib.mkOption {
      description = "The website package to use.";
      type = lib.types.package;
    };

    port = lib.mkOption {
      default = 8000;
      description = "The port to run the application on.";
      type = lib.types.ints.unsigned;
    };
  };

  config.services.website = {
    package = lib.mkDefault package;
  };

  config.systemd.services.emo-gay-website = lib.mkIf cfg.enable {
    enable = true;
    after = [ "network.target" ];
    wantedBy = [ "default.target" ];
    description = "My beautiful website";

    serviceConfig = {
      Type = "simple";
      ExecStart = "${lib.getExe cfg.package.serve} ${toString cfg.port}";
    };
  };
}
