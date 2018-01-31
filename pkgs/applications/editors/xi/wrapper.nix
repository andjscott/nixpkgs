{ stdenv,
  xi-core,
  frontend,
  makeWrapper
}:

stdenv.mkDerivation rec {
  name = frontend.name + "-wrapped";

  buildCommand = let bin="${xi-core}/bin/xi"; in ''
    makeWrapper ${frontend}/bin/${frontend.bname} $out/bin/${frontend.bname} \
    --prefix PATH : $out/${xi-core}
  '';

  buildInputs = [makeWrapper];

  meta = frontend.meta;
}
