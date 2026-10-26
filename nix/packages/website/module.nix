{
  config,
  lib,
  pkgs,
  self,
  ...
}:
let
  manifest = lib.importJSON "${self}/package.json";

  package = pkgs.buildNpmPackage {
    pname = manifest.name;
    version = manifest.version;
    src = self;
    npmDepsHash = "sha256-G+yWTYu4ZVHhlNvJJfxyWljaFKiZWsiprREvarWD040=";

    nativeBuildInputs = [
      pkgs.secretspec
    ];

    buildPhase = ''
      runHook preBuild
      cp "${config.environmentFile}" "./.env"
      npm run build
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      cp -r "./dist" "$out"
      runHook postInstall
    '';

    passthru = {
      serve = serveScript;
    };

    meta = {
      description = "My beautiful website";
      licenses = [ lib.licenses.eupl12 ];
      platforms = lib.platforms.all;
    };
  };

  serveScript = pkgs.writeShellApplication {
    name = "serve";
    text = ''simple-http-server --index "${package}" --port "''${1:-8000}"'';
    runtimeInputs = [ pkgs.simple-http-server ];
  };
in
{
  options = {
    environmentFile = lib.mkOption {
      default = "${self}/.env.template";
      description = "The path to the environment file to use.";
      type = lib.types.path;
    };

    output = lib.mkOption {
      description = "The final website package.";
      readOnly = true;
      type = lib.types.package;
    };
  };

  config = {
    output = package;
  };
}
