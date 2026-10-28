{
  lib,
  self,

  buildNpmPackage,
  writeShellApplication,

  secretspec,
  simple-http-server,
}:
let
  manifest = lib.importJSON "${self}/package.json";

  package = buildNpmPackage {
    pname = manifest.name;
    version = manifest.version;
    src = self;
    npmDepsHash = "sha256-xmZWHytlJgW4LDzsUi1Cd5VB2IVecvuFdObesjFWPEg=";

    LASTFM_API_KEY = "7b46fef74b3e8def3e1e95826097a792";

    nativeBuildInputs = [
      secretspec
    ];

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

    passthru = {
      inherit serve;
    };

    meta = {
      description = "My beautiful website";
      licenses = [ lib.licenses.eupl12 ];
      platforms = lib.platforms.all;
    };
  };

  serve = writeShellApplication {
    name = "serve";
    text = ''simple-http-server --index "${package}" --port "''${1:-8000}"'';
    runtimeInputs = [ simple-http-server ];
  };
in
package
