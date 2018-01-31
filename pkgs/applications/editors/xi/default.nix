{ stdenv, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  name = "xi-core-${version}";
  version = "v0.2.0";

  src = fetchFromGitHub {
    owner = "google";
    repo = "xi-editor";
    rev = "${version}";
    sha256 = "1k4sfwm9k3z8ldhr94ap2pf3xk97ghj6yydwwdfhyjlcxixd197b";
    };

  sourceRoot = "source/rust";

  buildInputs = [ ];

  cargoSha256 = "18ypix6xnvvsmfh5z860vmqbda49h7fvdmbpwcmiryq7d31qpb3b";

  meta = with stdenv.lib; {
    description = " A modern editor with a backend written in Rust.";
    homepage = https://github.com/google/xi-editor;
    license = licenses.asl20;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };
}
