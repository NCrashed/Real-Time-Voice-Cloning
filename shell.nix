
let
  config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      python37Packages = pkgs.python37Packages.override {
        overrides = self: super: {
          visdom = self.callPackage ./visdom.nix {};
          torchfile = self.callPackage ./torchfile.nix {};
        };
      };
    };
  };
in { pkgs ? import <nixpkgs> { inherit config; } }:

pkgs.stdenv.mkDerivation {
   name = "cuda-env-shell";
   buildInputs = with pkgs;
                  [ git gitRepo gnupg autoconf curl
                    procps gnumake utillinux m4 gperf unzip
                    cudatoolkit linuxPackages.nvidia_x11
                    libGLU
                    xorg.libXi xorg.libXmu freeglut
                    xorg.libXext xorg.libX11 xorg.libXv xorg.libXrandr zlib
                    ncurses5 stdenv.cc binutils
                    qt5.wrapQtAppsHook
                    python37 ffmpeg
                    python37Packages.pytorch
                    python37Packages.pip
                    python37Packages.webrtcvad
                    python37Packages.tensorflowWithCuda
                    python37Packages.umap-learn
                    python37Packages.visdom
                    python37Packages.librosa
                    python37Packages.matplotlib
                    python37Packages.numpy
                    python37Packages.scipy
                    python37Packages.tqdm
                    python37Packages.sounddevice
                    python37Packages.soundfile
                    python37Packages.unidecode
                    python37Packages.inflect
                    python37Packages.pyqt5
                    python37Packages.multiprocess
                    python37Packages.numba
                    gcc
                    glibc
                   ];
   shellHook = ''
      export CUDA_PATH=${pkgs.cudatoolkit}
      export LD_LIBRARY_PATH=${pkgs.linuxPackages.nvidia_x11}/lib:${pkgs.ncurses5}/lib:${pkgs.gcc-unwrapped.lib}/lib
		  export EXTRA_LDFLAGS="-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib"
		  export EXTRA_CCFLAGS="-I/usr/include"

      export QT_PLUGIN_PATH=${pkgs.qt5.qtbase.bin}/lib/qt-5.12.7/plugins:$QT_PLUGIN_PATH
      export QT_PLUGIN_PATH=${pkgs.qt5.qtsvg.bin}/lib/qt-5.12.7/plugins:$QT_PLUGIN_PATH
      export QT_PLUGIN_PATH=${pkgs.qt5.qtdeclarative.bin}/lib/qt-5.12.7/plugins:$QT_PLUGIN_PATH
      export QML2_IMPORT_PATH=${pkgs.qt5.qtdeclarative.bin}/lib/qt-5.12.7/qml:$QML2_IMPORT_PATH
      export QML2_IMPORT_PATH=${pkgs.qt5.qtquickcontrols}/lib/qt-5.12.7/qml:$QML2_IMPORT_PATH
      export QT_PLUGIN_PATH=${pkgs.qt5.qtwayland.bin}/lib/qt-5.12.7/plugins:$QT_PLUGIN_PATH
      export QML2_IMPORT_PATH=${pkgs.qt5.qtwayland.bin}/lib/qt-5.12.7/qml:$QML2_IMPORT_PATH
   '';
}
