{
  description = "Wayland Dashboard.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, quickshell }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = [
        (quickshell.packages.${pkgs.system}.default.override {
          withX11 = false;
          withI3 = false;
        })
        pkgs.qt6.qtdeclarative
      ];
      shellHook = ''
        echo "Quickshell `qs --version`"
      '';
    };
  };
}
