{
  lib,
  moonPlatform,
  moonRegistryIndex,
  stdenv,
}:
let
  dependencies = {
    "totto2727/admiral" = "0.6.2";
    "totto2727/lens" = "0.4.1";
    "moonbitlang/async" = "0.20.3";
  };
  cachedRegistry = moonPlatform.buildCachedRegistry {
    moonModDepsSet = dependencies;
    registryIndexSrc = moonRegistryIndex;
  };
  moonHome = moonPlatform.bundleWithRegistry {
    inherit cachedRegistry;
  };
  packageSrc = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [
      ./moon.mod
      ./README.mbt.md
      ./README.md
      ./src
    ];
  };
in
stdenv.mkDerivation {
  pname = "wt";
  version = "0.1.3";
  src = packageSrc;
  nativeBuildInputs = [ moonHome ];
  dontConfigure = true;
  buildPhase = ''
    runHook preBuild

    writable_home="$TMPDIR/moon_home"
    cp -rL ${moonHome} "$writable_home"
    chmod -R u+w "$writable_home"
    export MOON_HOME="$writable_home"
    export HOME="$TMPDIR"

    moon_bin="$MOON_HOME/bin/.moon-wrapped"
    "$moon_bin" build --release --strip

    runHook postBuild
  '';
  installPhase = ''
    runHook preInstall

    mkdir -p "$out/bin"
    install -Dm755 _build/native/release/build/wt.exe "$out/bin/wt"

    runHook postInstall
  '';
  meta = {
    description = "Native MoonBit Git worktree manager with PR awareness";
    homepage = "https://github.com/totto2727-org/wt";
    license = lib.licenses.mit;
    mainProgram = "wt";
  };
}
