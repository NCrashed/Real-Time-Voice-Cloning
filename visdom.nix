{ lib
, stdenv
, buildPythonPackage
, fetchPypi
, numpy
, scipy
, requests
, tornado
, pyzmq
, six
, jsonpatch
, torchfile
, websocket_client
, pillow
}:

buildPythonPackage rec {
  pname = "visdom";
  version = "0.1.7";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1gd8s7qx6azi6aczj7sib4ajj31ns0ls8s9wrcchi2ibj4g2qwv2";
  };

  doCheck = false;

  propagatedBuildInputs = [
    numpy
    scipy
    requests
    tornado
    pyzmq
    six
    jsonpatch
    torchfile
    websocket_client
    pillow
  ];

  meta = with lib; {
    description = "A flexible tool for creating, organizing, and sharing visualizations of live, rich data. Supports Torch and Numpy.";
    license = licenses.asl20;
    homepage = "https://github.com/facebookresearch/visdom";
  };
}
