# Option 1: SDDM Astronaut Theme (includes Japanese aesthetic and other variants)
{ lib
, stdenvNoCC
, fetchFromGitHub
, qt6
}:

stdenvNoCC.mkDerivation rec {
  pname = "sddm-astronaut-theme";
  version = "1.0-unstable-2025-01-05";
  
  dontBuild = true;
  dontWrapQtApps = false;
  
  src = fetchFromGitHub {
    owner = "Keyitdev";
    repo = "sddm-astronaut-theme";
    rev = "b42a427c9dbde8e8c5ca2fcf2e002559c0a7db04"; # Update with latest commit
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # Run nix-prefetch-url to get this
  };

  propagatedUserEnvPkgs = [
    qt6.qt5compat
    qt6.qtdeclarative
    qt6.qtsvg
    qt6.qtvirtualkeyboard
    qt6.qtmultimedia
  ];

  installPhase = ''
    mkdir -p $out/share/sddm/themes/sddm-astronaut-theme
    cp -aR $src/* $out/share/sddm/themes/sddm-astronaut-theme/
    
    # Install fonts
    mkdir -p $out/share/fonts
    cp -aR $src/Fonts/* $out/share/fonts/
  '';

  postInstall = ''
    # Set the default theme to Japanese aesthetic (Tokyo-style)
    # You can change this to any variant in the Themes/ directory:
    # astronaut.conf, black_hole.conf, japanese_aesthetic.conf, 
    # pixel_sakura_static.conf, purple_leaves.conf, cyberpunk.conf, 
    # post-apocalyptic_hacker.conf, hyprland_kath.conf, pixel_sakura.conf, jake_the_dog.conf
    
    substituteInPlace $out/share/sddm/themes/sddm-astronaut-theme/metadata.desktop \
      --replace "ConfigFile=Themes/astronaut.conf" "ConfigFile=Themes/japanese_aesthetic.conf"
  '';

  meta = with lib; {
    description = "Modern SDDM theme with multiple variants including Japanese aesthetic";
    homepage = "https://github.com/Keyitdev/sddm-astronaut-theme";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = [ ];
  };
}
