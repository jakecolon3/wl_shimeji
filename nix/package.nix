{
  lib,
  symlinkJoin,
  python3,
  python3Packages,
  wl_shimeji-unwrapped,
}:

symlinkJoin {
  pname = "wl_shimeji";
  inherit (wl_shimeji-unwrapped) version;

  paths = [
    wl_shimeji-unwrapped
  ];

  nativeBuildInputs = [
    python3Packages.wrapPython
  ];

  pythonInputs = with python3Packages; [
    pillow
  ];

  postBuild = ''
    buildPythonPath "$pythonInputs"

    wrapProgram $out/bin/shimejictl \
      --prefix PATH : $program_PATH \
      --set PYTHONHOME ${python3} \
      --set PYTHONPATH $program_PYTHONPATH
  '';

  meta = wl_shimeji-unwrapped.meta // {
    hydraPlatforms = [ ];
    priority = (wl_shimeji-unwrapped.meta.priority or lib.meta.defaultPriority) - 1;
  };
}
