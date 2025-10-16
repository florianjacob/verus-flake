{ lib
, rustPlatform
, makeBinaryWrapper
, rust-bin
, rustup
, vargo
, z3
}:

rustPlatform.buildRustPackage {
  pname = "verus";
  inherit (vargo) version src;

  sourceRoot = "source/source";

  cargoHash = "sha256-PCJun6ivddin/EfuCZrhGt0lhb2dD439KzcYKcM+0C8=";

  nativeBuildInputs = [ makeBinaryWrapper rust-bin rustup vargo z3 ];

  buildInputs = [ rustup z3 ];

  buildPhase = ''
    runHook preBuild

    ln -s ${lib.getExe z3} ./z3
    vargo build --release

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r target-verus/release -T $out

    mkdir -p $out/bin
    ln -s $out/verus $out/bin/verus
    ln -s $out/rust_verify $out/bin/rust_verify
    ln -s $out/cargo-verus $out/bin/cargo-verus
    ln -s $out/z3 $out/bin/z3

    wrapProgram $out/bin/verus --prefix PATH : ${lib.makeBinPath [ rustup ]}

    runHook postInstall
  '';

  # no tests, verified when built
  doCheck = false;

  meta = {
    homepage = "https://github.com/verus-lang/verus";
    description = "Verified Rust for low-level systems code";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ stephen-huan ];
    platforms = [
      "x86_64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
      "x86_64-windows"
    ];
    mainProgram = "verus";
  };
}
