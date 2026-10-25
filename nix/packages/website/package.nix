{
  lib,
  self,

  buildNpmPackage,
  writeShellApplication,

  simple-http-server,
}:
let
  manifest = lib.importJSON "${self}/package.json";

  package = buildNpmPackage {
    pname = manifest.name;
    version = manifest.version;
    src = self;
    npmDepsHash = "sha256-dYQdP8ucUOjfVjeN5FTXLPkSOlQi7Jcx4+UWxG146+0=";

    buildPhase = ''
      runHook preBuild
      npm run build
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      cp -r "./dist" "$out"
      runHook postInstall
    '';

    meta = {
      description = "My beautiful website";
      licenses = [ lib.licenses.eupl12 ];
      platforms = lib.platforms.all;
    };
  };

  serveScript = writeShellApplication {
    name = "serve";
    text = ''simple-http-server --index "${package}" --port "''${1:-8000}"'';
    runtimeInputs = [ simple-http-server ];
  };
in
package.overrideAttrs (finalAttrs: prevAttrs: { passthru.serve = serveScript; })
