{
  description = "elm-either";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        name = "elm-either";

        pkgs = import nixpkgs { inherit system; };

        ruby = pkgs.ruby_2_7;

        nodejs = pkgs.nodejs-14_x;
      in
      rec {
        inherit name;
        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            elmPackages.elm-format
            nodejs
          ];
        };
      }
    );
}
