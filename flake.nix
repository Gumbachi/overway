{
  description = "Wayland Dashboard.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    # forAllSystems = fn:
    #   nixpkgs.lib.genAttrs nixpkgs.lib.platforms.linux (
    #     system: fn nixpkgs.legacyPackages.${system}
    #   );
  in {
    # Dev Shell
    devShells.${system}.default = pkgs.mkShell {
      packages = [
        pkgs.quickshell
        pkgs.kdePackages.qtdeclarative
        pkgs.nerd-fonts.symbols-only
        pkgs.nerd-fonts.blex-mono
      ];
      # shellHook = ''
      #   echo "Quickshell `qs --version`"
      # '';
    };

    # Derivation
    # packages.${pkgs.system}.default = pkgs.stdenv.mkDerivation {
    #   name = "overway";
    #   buildCommand = ''
    #     echo '#!/bin/bash' > $out
    #     echo 'echo "Hello, World!"' >> $out
    #     chmod +x $out
    #   '';
    # };

  };
}
