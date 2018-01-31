{ pkgs, stdenv, fetchFromGitHub, rustPlatform, makeWrapper, gnome3 }:

let
  pkg = rustPlatform.buildRustPackage rec {
    bname = "gxi";
    name = "gxi-unstable-${version}";
    version = "7e9744a";

    src = fetchFromGitHub {
        owner = "bvinc";
        repo = "gxi";
        rev = "${version}";
        sha256 = "18dq88vfxlzis11smc2xjssg9ygqjjh52r16iihpj9k2n7328ql6";
  };

    buildInputs = [ pkgs.gtk3 ];

    cargoSha256 = "10ypajgp91a6v60pn8m076qdc9bfgfmksp5q70n5w7gamwd66acv";

    patches = [ ./fix_resources_directory.patch ];

    preInstallHook = ''
        install -D resources/gxi.ui $out/usr/share/gxi/resources/gxi.ui
    '';

    meta = with stdenv.lib; {
        description = "GTK frontend for the xi text editor, written in rust";
        homepage = https://github.com/bvinc/gxi;
        license = licenses.mit;
        maintainers = with maintainers; [  ];
        platforms = platforms.all;
    };
    };
in
stdenv.mkDerivation rec {
  bname = pkg.bname;
  name = pkg.name;
  # https://github.com/NixOS/nixpkgs/issues/26560#issuecomment-308202982
  buildCommand = ''
    makeWrapper ${pkg}/bin/gxi $out/bin/gxi \
    --prefix XDG_DATA_DIRS : "$GSETTINGS_SCHEMAS_PATH" \
    --suffix XDG_DATA_DIRS : '${gnome3.defaultIconTheme}/share'
  ''
  ;

  buildInputs = [makeWrapper];

  pathsToLink = [
    "/usr"
  ];

  meta = pkg.meta;
}
