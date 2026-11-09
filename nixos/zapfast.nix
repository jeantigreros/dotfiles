{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "zapfast";
  version = "0.21.1";

  src = pkgs.fetchzip {
    url = "https://github.com/crmne/zapfast/releases/download/v${version}/zapfast-v${version}-x86_64-unknown-linux-gnu.tar.gz";

    # Replace with the hash obtained in step 2.
    hash = "sha256:18a32vka5ld4m28rq0jq3rdisph619xx5h9gk4chnknkz3r8ydjn";
  };

  nativeBuildInputs = [
    pkgs.autoPatchelfHook
    pkgs.makeWrapper
  ];

  buildInputs = with pkgs; [
    alsa-lib
    pipewire
    libGL
    libxkbcommon
    wayland
    libX11
    libxcursor
    libXi
    libXrandr
  ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -Dm755 "$(find . -type f -name zapfast -print -quit)" \
      $out/bin/zapfast

    desktop=$(find . -type f -name zapfast.desktop -print -quit)
    if [ -n "$desktop" ]; then
      install -Dm644 "$desktop" \
        $out/share/applications/zapfast.desktop
    fi

    icon=$(find . -type f -name zapfast.svg -print -quit)
    if [ -n "$icon" ]; then
      install -Dm644 "$icon" \
        $out/share/icons/hicolor/scalable/apps/zapfast.svg
    fi

    wrapProgram $out/bin/zapfast \
      --prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath buildInputs}

    runHook postInstall
  '';

  meta = {
    description = "Native WhatsApp client";
    homepage = "https://zapfast.rocks";
    mainProgram = "zapfast";
    platforms = [ "x86_64-linux" ];
  };
}
