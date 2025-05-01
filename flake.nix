{
  description = "Desktop overlay for Wayland.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ags }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    packages.${system}.default = ags.lib.bundle {
      inherit pkgs;
      src = ./src;
      name = "overway";
      entry = "app.ts";
      gtk4 = false;
      extraPackages = with ags.packages.${system};[
        mpris
        network
        tray
        hyprland
        wireplumber
        notifd
      ];
    };
  };
}
