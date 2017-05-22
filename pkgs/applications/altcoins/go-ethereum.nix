{ stdenv, lib, clang, buildGoPackage, fetchgit }:

buildGoPackage rec {
  name = "go-ethereum-${version}";
  version = "1.6.1";
  rev = "refs/tags/v${version}";
  goPackagePath = "github.com/ethereum/go-ethereum";

  buildInputs = [ clang ];

  src = fetchgit {
    inherit rev;
    url = "https://${goPackagePath}";
    sha256 = "02w5zjs40iznnph6c0kp34c84nrx3dkdarcpdyawkjpwjvxkw05g";
  };

  preBuild = ''
    # use clang as a workaround for
    # https://github.com/NixOS/nixpkgs/issues/25959
    export CC="clang"
  '';

  meta = {
    homepage = "https://ethereum.github.io/go-ethereum/";
    description = "Official golang implementation of the Ethereum protocol";
    license = with lib.licenses; [ lgpl3 gpl3 ];
  };
}
