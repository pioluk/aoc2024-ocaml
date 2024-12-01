{
  description = "Advent of Code 2024 in OCaml";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system}.appendOverlays [
          (self: super: { ocamlPackages = super.ocaml-ng.ocamlPackages_5_2; })
        ];
        inherit (pkgs) ocamlPackages;
      in

      {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with ocamlPackages; [
            ocaml
            dune_3
            findlib
            ocaml-lsp
            ocamlPackages.base
            ocamlPackages.merlin
            ocamlPackages.ocamlformat
            ocamlPackages.re
            ocamlPackages.stdio
            ocamlPackages.utop
          ];
        };
      });
}
