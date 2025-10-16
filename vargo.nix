{ lib
, fetchFromGitHub
, rustPlatform
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "vargo";
  version = "0.2025.10.05.bf8e97e";

  src = fetchFromGitHub {
    owner = "verus-lang";
    repo = "verus";
    tag = "release/${finalAttrs.version}";
    hash = "sha256-66F1YBjqpNrQVqdOjJqYbUhSmJPOeup8DIbyPA+nkiE=";
  };

  sourceRoot = "source/tools/vargo";

  cargoHash = "sha256-0WJEW3FtoWxMaedqBoCmaS0HLsLjxtBlBClAXcjf/6s=";

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
    mainProgram = "vargo";
  };
})
