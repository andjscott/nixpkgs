{ stdenv, fetchFromGitHub, rustPlatform, makeWrapper, gtk3, gnome3, wrapGAppsHook}:

rustPlatform.buildRustPackage rec {
  bname = "gxi";
  name = "gxi-unstable-${version}";
  version = "7e9744aad2b73ce29d8e174b3bd24718ff87a35d";

  src = fetchFromGitHub {
    owner = "bvinc";
    repo = "gxi";
    rev = "${version}";
    sha256 = "18dq88vfxlzis11smc2xjssg9ygqjjh52r16iihpj9k2n7328ql6";
  };

  buildInputs = [
    gtk3
    wrapGAppsHook
  ];

  cargoSha256 = "10ypajgp91a6v60pn8m076qdc9bfgfmksp5q70n5w7gamwd66acv";

  postPatch = ''
    substituteInPlace src/ui.rs \
      --replace resources/gxi.ui $out/usr/share/gxi/resources/gxi.ui
  '';

  postInstall = ''
    install -D resources/gxi.ui $out/usr/share/gxi/resources/gxi.ui
  '';

  meta = with stdenv.lib; {
    description = "GTK frontend for the xi text editor, written in rust";
    homepage = https://github.com/bvinc/gxi;
    license = licenses.mit;
    maintainers = with maintainers; [  ];
    platforms = platforms.all;
  };
}
