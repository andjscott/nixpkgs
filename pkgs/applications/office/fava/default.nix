{ stdenv, pkgs, python3Packages, fetchzip, python3 }:

python3Packages.buildPythonApplication rec {
  version = "1.5";
  name = "fava-${version}";

  src = fetchzip {
    name = "${name}-src";
    url = "https://github.com/beancount/fava/archive/v${version}.zip";
    sha256 = "c370eca6de0a4a324eb8e25105d2a31deb7630fa84067a4a0baa7e2ad87b8f0f";
  };

  buildInputs = with python3Packages; [ pytest ];

  doCheck = false;
  checkPhase = ''
    # pyexcel is optional
    # the other 2 tests fail due non-unicode locales
    PATH=$out/bin:$PATH pytest tests \
      --ignore tests/test_util_excel.py \
      --ignore tests/test_cli.py \
      --ignore tests/test_translations.py \
  '';

  propagatedBuildInputs = with python3Packages;
    [ flask dateutil pygments wheel markdown2 flaskbabel tornado
      click pkgs.beancount ];

  meta = {
    homepage = https://github.com/aumayr/fava;
    description = "Web interface for beancount";
    license = stdenv.lib.licenses.mit;
    maintainers = with stdenv.lib.maintainers; [ matthiasbeyer ];
  };
}

