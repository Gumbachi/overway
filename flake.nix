{
  description = "Desktop overlay for Wayland.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    ags.url = "github:aylur/ags";
    ags.inputs.nixpkgs.follows = "nixpkgs";

    astal.url = "github:aylur/astal";
    astal.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ags, astal, }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    packages.${system}.default = pkgs.stdenvNoCC.mkDerivation { 
      name = "overway";
      src = ./src/.;

      nativeBuildInputs = [
        pkgs.wrapGAppsHook
        pkgs.gobject-introspection
        pkgs.esbuild
        pkgs.meson
        pkgs.ninja
        pkgs.pkg-config
      ];

      buildInputs = [
        pkgs.gjs
        pkgs.glib
        pkgs.gtk3
        astal.packages.${system}.io
        astal.packages.${system}.astal3
        astal.packages.${system}.mpris
        astal.packages.${system}.network
        astal.packages.${system}.tray
        astal.packages.${system}.hyprland
        astal.packages.${system}.wireplumber
        astal.packages.${system}.notifd
      ];

    };

    # packages.${system}.default = pkgs.stdenv.mkDerivation {
    #   name = pname;
    #   src = ./src;
    #
    #   nativeBuildInputs = with pkgs; [
    #     wrapGAppsHook
    #     gobject-introspection
    #     ags.packages.${system}.default
    #   ];
    #
    #   buildInputs = extraPackages ++ [pkgs.gjs];
    #
    #   installPhase = ''
    #     runHook preInstall
    #
    #     mkdir -p $out/bin
    #     mkdir -p $out/share
    #     cp -r * $out/share
    #     ags bundle ${entry} $out/bin/${pname} --gtk 3 -d "SRC='$out/share'"
    #
    #     runHook postInstall
    #   '';
    # };

    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with ags.packages.${system}; [
        astal3
        io
        mpris
        network
        tray
        hyprland
        wireplumber
        notifd
      ];

      shellHook = ''
        echo "ags `ags --version`"
      '';
    };
  };
}








# {
#   description = "Desktop overlay for Wayland.";
#
#   inputs = {
#     nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
#
#     astal.url = "github:aylur/astal";
#     astal.inputs.nixpkgs.follows = "nixpkgs";
#
#     ags.url = "github:aylur/ags";
#     ags.inputs.nixpkgs.follows = "nixpkgs";
#     ags.inputs.astal.follows = "astal";
#   };
#
#   outputs = { self, nixpkgs, ags, astal }:
#   let
#     system = "x86_64-linux";
#     pkgs = nixpkgs.legacyPackages.${system};
#   in
#   {
#
#     packages.${system}.default = pkgs.stdenv.mkDerivation { 
#       pname = "overway";
#       src = ./src;
#
#       nativeBuildInputs = with pkgs; [
#         wrapGAppsHook
#         gobject-introspection
#         ags.packages.${system}.default
#       ];
#
#       buildInputs = [
#         pkgs.glib
#         pkgs.astal.gjs
#
#         astal.astal3
#         astal.io
#         astal.mpris
#         astal.network
#         astal.tray
#         astal.hyprland
#         astal.wireplumber
#         astal.notifd
#       ];
#
#       installPhase = ''
#         ags bundle app.ts $out/bin/overway
#       '';
#
#       preFixup = ''
#         gappsWrapperArgs+=(
#           --prefix PATH : ${pkgs.lib.makeBinPath ([
#             # runtime executables
#           ])}
#         )
#       '';
#     };
#
#     # Dev Shell
#     devShells.${system}.default = pkgs.mkShell {
#       buildInputs = [
#         (ags.packages.${system}.default.override { 
#           extraPackages = [
#             # cherry pick packages
#           ];
#         })
#       ];
#
#       shellHook = ''
#         echo "astal `astal --version`"
#       '';
#     };
#
#   };
# }
