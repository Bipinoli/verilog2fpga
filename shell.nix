{ pkgs ? import <nixpkgs> {} }:

let 
  haskellPackages = pkgs.haskellPackages;
  icedudeSrc = pkgs.fetchFromGitHub {
    owner = "reactive-systems";
    repo = "icedude";
    rev = "f70a86dcc901d4f1873b3da881ddfa5739bb82df"; # commit hash with commit message "GHC 9.6 support"
    hash = "sha256-UnrLSxVFdkC1uOiYsI4LtKgaEO6+AzRp3740TlL2DFM=";
  };
in
pkgs.mkShell {
  name = "verilog to fpga synthesis toolchain";

  buildInputs = with pkgs; [
    pkg-config-unwrapped
    yosys # Open RTL synthesis framework and tools
    nextpnr # Place and route tool for FPGAs
    icestorm # Documentation and tools for Lattice iCE40 FPGAs

    libusb1 # icedude depends on it
    haskellPackages.bindings-libusb # icedude depends on it
    haskellPackages.cabal-install # to build icedude
    haskellPackages.ghc # to build icedude
  ];

  shellHook = ''
    echo "Building icedude from source .."
    cd ${icedudeSrc}
    sudo cabal build
    sudo cabal install
    echo "icedude built successfully!"

    echo "---------------------------------------------------------"
    echo "Yosys is available. Verify by calling 'yosys -h'"
    echo "Nextpnr is available. Verify by calling 'nextpnr-ice40 -h'"
    echo "icepack is available. Verify by calling 'icepack -h'"
    echo "iceprog is available. Verify by calling 'iceprog --help'"
    echo "icedude is available. Verify by calling 'icedude -h'"
  '';
}
