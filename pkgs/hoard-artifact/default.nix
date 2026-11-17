{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  aws-lc,
  cacert,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  # The NUR attribute is hoard-artifact to match the nixpkgs name and avoid
  # confusion with the unrelated Hyde46/hoard package. The installed binaries
  # and pname keep the upstream name hoard.
  pname = "hoard";
  version = "0.1.0";
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "meillaya";
    repo = "hoard";
    # Upstream tags releases; v0.1.0 is the first published crate set.
    rev = "v0.1.0";
    hash = "sha256-cJka6IG5DIKAX4EPMeAUBt51qT9Ov3Pb7FLX3bI3cGk=";
  };

  cargoHash = "sha256-z0B467EbW+XYK6zmzVuNdX/VpPUzzVI43d+DJIqa8DM=";

  # Build the whole workspace: an install hook copies every binary to $out/bin,
  # so both `hoard` and `hoard-gguf` land there.
  cargoBuildFlags = [
    "--workspace"
  ];
  cargoTestFlags = [
    "--workspace"
  ];

  # reqwest and hf-xet activate aws-lc-rs through rustls; nixpkgs sets
  # AWS_LC_SYS_USE_SYSTEM=1 for Rust builds, so provide the library instead of
  # letting aws-lc-sys build its own copy.
  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ aws-lc ];

  # The Hub client tests construct a reqwest client with the system root store;
  # point it at nixpkgs' CA bundle so `cargo test` works in the sandbox.
  preCheck = ''
    export SSL_CERT_FILE="${cacert}/etc/ssl/certs/ca-bundle.crt"
    export SSL_CERT_DIR="${cacert}/etc/ssl/certs"
  '';

  meta = {
    description = "Verifiable, content-addressed artifacts for large model files";
    longDescription = ''
      hoard inspects GGUF model files without decoding their tensors, computes
      SHA-256 and BLAKE3 digests, pins artifact sets in canonical manifests, and
      downloads files from the Hugging Face Hub with digest verification. The
      package installs the `hoard` artifact CLI and the `hoard-gguf` inspector.
    '';
    homepage = "https://github.com/meillaya/hoard";
    changelog = "https://github.com/meillaya/hoard/blob/${finalAttrs.src.rev}/CHANGELOG.md";
    license = lib.licenses.asl20;
    maintainers = [
      {
        name = "Meillaya";
        email = "nathanagbomed@proton.me";
        github = "meillaya";
        githubId = 105596849;
      }
    ];
    mainProgram = "hoard";
    platforms = lib.platforms.unix;
  };
})
